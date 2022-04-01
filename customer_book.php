<?php
session_start();
include('db_connect.php');
if(isset($_GET['id']) && !empty($_GET['id']) ){
	$qry = $conn->query("SELECT * FROM schedule_list where id = ".$_GET['id'])->fetch_array();
	foreach($qry as $k => $val){
		$meta[$k] =  $val;
	}
$bus = $conn->query("SELECT * FROM bus where id = ".$meta['bus_id'])->fetch_array();
$from_location = $conn->query("SELECT id,Concat(terminal_name,', ',city,', ',state) as location FROM location where id =".$meta['from_location'])->fetch_array();
$to_location = $conn->query("SELECT id,Concat(terminal_name,', ',city,', ',state) as location FROM location where id =".$meta['to_location'])->fetch_array();
# I uncommented this shit
$count = $conn->query("SELECT SUM(qty) as sum from booked where schedule_id =".$meta['id'])->fetch_array()['sum'];
}
if(isset($_SESSION['login_id']) && isset($_GET['bid'])){
	$booked = $conn->query("SELECT * FROM booked where id=".$_GET['bid'])->fetch_array();
	foreach($booked as $k => $val){
		$bmeta[$k] =  $val;
	}
}
?>
<div class="container-fluid">
	<form id="manage_book">
		<div class="col-md-12">
			<p><b>Bus:</b> <?php echo $bus['bus_number'] . ' | '.$bus['name'] ?></p>
			<p><b>From:</b> <?php echo $from_location['location'] ?></p>
			<p><b>To:</b> <?php echo $to_location['location'] ?></p>
			<p><b>Departure Time</b>: <?php echo date('M d,Y h:i A',strtotime($meta['departure_time'])) ?></p>
			<p><b>Estimated Time of Arrival:</b> <?php echo date('M d,Y h:i A',strtotime($meta['eta'])) ?></p>
			<!-- <?php if(($count < $meta['availability']) || isset($_SESSION['login_id'])): ?> -->
			<input type="hidden" class="form-control" id="sid" name="sid" value='<?php echo isset($_GET['id']) ? $_GET['id'] : '' ?>' required="">
			<input type="hidden" class="form-control" id="sid" name="bid" value='<?php echo isset($_GET['bid']) ? $_GET['bid'] : '' ?>' required="">
			
			<div class="form-group mb-2">
				<label for="name" class="control-label"><b>Name</b></label>
				<input type="text" class="form-control" id="name" name="name" value="<?php echo isset($bmeta['name']) ? $bmeta['name'] : '' ?>">
			</div>
			<div class="form-group mb-2">
				<label for="qty" class="control-label"><b>Quantity of seats</b></label>
				<input type="number" maxlength="4" class="form-control text-right" id="qty" name="qty" value="<?php echo isset($bmeta['qty']) ? $bmeta['qty'] : '' ?>">
			</div>
			<!-- embrace changes -->
			<div class="form-group mb-2">
				<label for="qty" class="control-label"><b>Payment Via mpesa </b><br> <ul><li> Go to the Lipa na MPESA menu and select PAYBILL</li>
			<li> Business Number: 308900</li>
		<li> Account Number Enter: TICKET</li>
	<li> Enter the fare KES .</li>
<li>Enter Your PIN Number.</li>
<li>Wait for the MPESA confirmation SMS</li>
<li>Fill this form and Submit Booking below.</li>
<li>Fill the following detailsr</li></ul>
<br><b>Enter your phone number</b>
</label>
				<input type="number" maxlength="10" class="form-control text-right" id="payment" name="payment" value="<?php echo isset($bmeta['payment']) ? $bmeta['payment'] : '' ?>">
			</div>
			<div class="form-group mb-2">
				<label for="qty" class="control-label"><b>Mpesa Transaction ID</b></label>
				<input type="varchar" class="form-control text-right" id="ID" name="ID" value="<?php echo isset($bmeta['ID']) ? $bmeta['ID'] : '' ?>">
			</div>
			<?php if(isset($_SESSION['login_id'])): ?>
			<div class="form-group mb-2">
				<label for="qty" class="control-label">Status</label>
				<select  class="form-control" id="status" name="status" value="<?php echo isset($bmeta['qty']) ? $bmeta['qty'] : '' ?>">
					<option value="1" <?php echo isset($bmeta['status']) && $bmeta['status'] == 1 ? "selected" : '' ?>>Paid</option>
					<option value="0" <?php echo isset($bmeta['status']) && $bmeta['status'] == 0 ? "selected" : '' ?>>Unpaid</option>
					</select>
			</div>
			<?php endif; ?>
			<?php else: ?>
			<h3>No Available seat</h3>
			<style>
				.uni_modal .modal-footer{
					display: none;
				}
			</style>
			<?php endif; ?>
		</div>
	</form>
</div>


<script>
	$('#manage_book').submit(function(e){
		e.preventDefault()
		start_load()
		$.ajax({
			url:'./book_now.php',
			method:'POST',
			data:$(this).serialize(),
			error:err=>{
				console.log(err)
    			end_load()
    			alert_toast('An error occured','danger');
			},
			success:function(resp){
				resp = JSON.parse(resp)
				if(resp.status == 1){
    				end_load()
    				$('.modal').modal('hide')
    				alert_toast('Data successfully saved','success');
    				if('<?php echo !isset($_SESSION['login_id']) ?>' == 1){
    				$('#book_modal .modal-body').html('<div class="text-center"><p><strong><h3>'+resp.ref+'</h3></strong></p><small>capture your ticket number</small><br/><small>Welcome again. </small></div>')
    				$('#book_modal').modal('show')
    				}else{
    					load_booked();
    				}
				}
			}
		})
	})
	$('.datetimepicker').datetimepicker({
	    format:'Y/m/d H:i',
	    startDate: '+3d'
	});
</script>