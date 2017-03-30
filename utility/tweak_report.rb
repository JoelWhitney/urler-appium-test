# ../reports/fail_continue.json  + ../reports/report.json ==> ../reports/result_tweaked.json

require 'json'
require 'pp'


if !File.exists?("../reports/fail_continue.json") or !File.exists?("../reports/result.json")
  print("not found fail_continue.json, or result.json \n")
  exit
end

if File.exists?("../reports/result_tweaked.json")
  File.delete("../reports/result_tweaked.json")
  print("../reports/result_tweaked.json deleted \n")
end


########### read the warning.json
warning_file_content=File.read("../reports/fail_continue.json")
warning_json = "[" + warning_file_content[0...-1] + "]"
warning_hash = JSON.load(warning_json)
pp warning_hash

######### read the result.json
report_hash = JSON.load(File.read("../reports/result.json"))

######### plug in warning into result.json
warning_hash.each do |key|
  _feature = key["feature"]
  _scenario = key["scenario"]
  _step = key["step"]
  _error_msg = key["error_message"]

  report_hash.find{|feature|feature['name']==_feature}['elements'].find{|scenario|scenario['name']==_scenario}['steps'].find{|step|step['name']==_step}['result']['status'] = 'failed'
  report_hash.find{|feature|feature['name']==_feature}['elements'].find{|scenario|scenario['name']==_scenario}['steps'].find{|step|step['name']==_step}['result']['error_message'] = _error_msg
end

########## write out the tweak report file
tweaked_report_file = File.open("../reports/result_tweaked.json", "w")
tweaked_report_file.write(JSON.dump(report_hash))
print("fail_continue.json merged to report.json ==> ../reports/result_tweaked.json \n")
