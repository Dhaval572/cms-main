<?php
include('config.php');
if(!isset($_SESSION['dept_head_id'])){
    header("Location: dept_head_login.php");
    exit;
}

// Get complaints assigned to this dept head that have not been assigned to an officer
$dept_head_id = $_SESSION['dept_head_id'];
$sql = "SELECT c.*, d.name as dept_name 
        FROM complaints c 
        LEFT JOIN departments d ON c.department_id = d.id 
        WHERE c.dept_head_id = '$dept_head_id' AND c.officer_id IS NULL 
        ORDER BY c.created_at DESC";
$result = $conn->query($sql);

// Fetch officers in the same department
$department_id = $_SESSION['dept_head_department'];
$officer_sql = "SELECT id, name FROM users WHERE role = 'officer' AND department_id = '$department_id'";
$officers = $conn->query($officer_sql);

if(isset($_POST['assign'])){
    $complaint_id = $_POST['complaint_id'];
    $officer_id   = $_POST['officer_id'];

    // Update complaint: assign officer and change status to in_progress
    $update_sql = "UPDATE complaints SET officer_id = '$officer_id', status = 'in_progress' WHERE id = '$complaint_id'";
    if($conn->query($update_sql)){
        // Log activity: Assigned to Officer
        $activity_sql = "INSERT INTO complaint_activity (complaint_id, activity, activity_by) VALUES ('$complaint_id', 'Assigned to Officer', '$dept_head_id')";
        $conn->query($activity_sql);
        $success = "Complaint #$complaint_id assigned successfully.";
    } else {
        $error = "Error assigning complaint: " . $conn->error;
    }
}
?>
<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8">
  <title>Assign Complaint</title>
  <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
</head>
<body>
<nav class="navbar navbar-expand-lg navbar-dark bg-dark">
  <span class="navbar-brand">Assign Complaint</span>
  <div class="ml-auto">
    <a href="dept_head_dashboard.php" class="btn btn-outline-light">Dashboard</a>
  </div>
</nav>
<div class="container mt-5">
  <h3>Complaints Pending Assignment</h3>
  <?php 
  if(isset($success)){ echo "<div class='alert alert-success'>$success</div>"; }
  if(isset($error)){ echo "<div class='alert alert-danger'>$error</div>"; }
  ?>
  <?php if($result && $result->num_rows > 0){ ?>
  <table class="table table-bordered table-striped">
    <thead>
      <tr>
        <th>Complaint ID</th>
        <th>Title</th>
        <th>Department</th>
        <th>Description</th>
        <th>Registered At</th>
        <th>Assign Officer</th>
      </tr>
    </thead>
    <tbody>
      <?php while($row = $result->fetch_assoc()){ ?>
      <tr>
        <td><?php echo $row['id']; ?></td>
        <td><?php echo htmlspecialchars($row['title']); ?></td>
        <td><?php echo htmlspecialchars($row['dept_name']); ?></td>
        <td><?php echo htmlspecialchars($row['description']); ?></td>
        <td><?php echo $row['created_at']; ?></td>
        <td>
          <form method="POST" action="">
            <input type="hidden" name="complaint_id" value="<?php echo $row['id']; ?>">
            <select name="officer_id" class="form-control" required>
              <option value="">Select Officer</option>
              <?php while($officer = $officers->fetch_assoc()){ ?>
              <option value="<?php echo $officer['id']; ?>"><?php echo htmlspecialchars($officer['name']); ?></option>
              <?php } ?>
            </select>
            <button type="submit" name="assign" class="btn btn-primary btn-sm mt-2">Assign</button>
          </form>
        </td>
      </tr>
      <?php 
      // Reset officers result pointer for each row
      $officers->data_seek(0);
      } ?>
    </tbody>
  </table>
  <?php } else { echo "<div class='alert alert-info'>No complaints pending assignment.</div>"; } ?>
</div>
</body>
</html>
