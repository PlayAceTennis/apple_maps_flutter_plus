Pod::Spec.new do |s|
  s.name             = 'apple_maps_flutter_plus'
  s.version          = '0.0.1'
  s.summary          = 'Apple Maps widget for Flutter (maintained fork).'
  s.description      = <<-DESC
Apple Maps widget for Flutter with Swift Package Manager support.
Maintained by Ace Labs UG (haftungsbeschränkt) / PlayAceTennis.
                       DESC
  s.homepage         = 'https://github.com/PlayAceTennis/apple_maps_flutter_plus'
  s.license          = { :type => 'BSD-2-Clause', :file => '../LICENSE' }
  s.author           = { 'Ace Labs UG (haftungsbeschränkt)' => 'info@playace.app' }
  s.source           = { :path => '.' }
  s.source_files = 'apple_maps_flutter_plus/Sources/apple_maps_flutter_plus/**/*.swift'
  s.dependency 'Flutter'
  s.ios.deployment_target = '15.0'
  s.swift_version = '5.9'
end
