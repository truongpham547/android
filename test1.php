<?php
    $apiKey  = 'API KEY GOES HERE';
    $address = urlencode( '1600 Amphitheatre Pkwy, Mountain View, CA 94043' );
    $url     = "https://maps.googleapis.com/maps/api/geocode/json?address={$address}key={apiKey}";
    $resp    = json_decode( file_get_contents( $url ), true );

    // Latitude and Longitude (PHP 7 syntax)
    $lat    = $resp['results'][0]['geometry']['location']['lat'] ?? '';
    $long   = $resp['results'][0]['geometry']['location']['lng'] ?? '';
    echo $lat;
    echo $long;
?>
