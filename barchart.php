<?php include'include\fusioncharts.php'; ?>

<?php
    $date = date("Y-m-d");
    $time = date ("Y-m-d", strtotime ($date ."-30 days"));
    $strQuery = "SELECT transaction_date,finance_type_id,SUM(amount) FROM finances WHERE transaction_date > $time GROUP BY transaction_date ORDER BY transaction_date ASC;";
    $result = mysqli_query($conn,$strQuery);
    
    if (mysqli_num_rows($result) > 0) {
        $arrData = array(
            "chart" => array(
            "caption"=> "Budget",
            "xAxisname"=> "Day",
            "yAxisName"=> "Money (In Rs.)",
            "numberPrefix"=> "Rs.",
            "legendItemFontColor"=> "#666666",
            "theme"=> "zune"
            )
        );
        
        // creating array for categories object
        $categoryArray=array();
        $dataseries1=array();
        $dataseries2=array();

        // pushing category array values
        while($row = mysqli_fetch_array($result)) {
            array_push($categoryArray, array(
                "label" => $row["transaction_date"]  //put categories here later
            )
            );
            array_push($dataseries1, array(
                "value" => $row["SUM(amount)"]
                )
            );
        }

        $arrData["categories"]=array(array("category"=>$categoryArray));
        
        // creating dataset object
        $arrData["dataset"] = array(array("seriesName"=> "Expense","data"=>$dataseries1));

        /*JSON Encode the data to retrieve the string containing the JSON representation of the data in the array. */
        $jsonEncodedData = json_encode($arrData);

        // chart object
        $msChart = new FusionCharts("mscombi2d", "chart1" , "100%", "100%", "chart-container", "json", $jsonEncodedData);

        // Render the chart
        $msChart->render();
   }

?>

<center>
    <div id="chart-container">
        Chart will render here!
    </div>
</center>