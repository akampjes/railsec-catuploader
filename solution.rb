require 'cgi'
require 'active_support'                                                       
                                                                               
def decrypt_session_cookie(cookie, key)                                        
  cookie = CGI::unescape(cookie)                                               
                                                                               
  # Default values for Rails 4 apps                                            
  key_iter_num = 1000                                                          
  salt         = "encrypted cookie"
  signed_salt  = "signed encrypted cookie"                                     
                                                                               
  key_generator = ActiveSupport::KeyGenerator.new(key, iterations: key_iter_num)
  secret = key_generator.generate_key(salt)                                    
  sign_secret = key_generator.generate_key(signed_salt)                        
                                                                               
  encryptor = ActiveSupport::MessageEncryptor.new(secret, sign_secret)
  encryptor.decrypt_and_verify(cookie)
end                                                                            

cookie = 'Q1o2QlVkcUI5VXF2TVI0cEFDbXBvdFI3K0R0OFZBZG91RWpnRi8rYWZOaTIvbUJmSVFmSm41ZXJ5czUzNDlMajl0a1l0MC9UcHdSTDF0Z3VSWllJVGY0S2duM2NwNy9CKyttVmErMmVpelhaQVNMZzlrcHpaR2x1dStZNWFKaC9CWVF3L3V1akRXMytSeEgwL1JOS0FzbWVNS05qMDkwanFXc2hIZFErNytnMExHTHJLK01MdUh3RmJOdU9HZFlVbzhjcmI5S3JZRWFkbmZUbzU2STlLc1NjMW4rYnhlQ3Y1VDFVT0wxU2ErQWxqZ0NNT1R3cUk1K3Fja0pYL09pMC0tdmtkb3hVUXFqUFFLbERrRzI4Ni9oQT09--0ba26fe2439256a59a0295c94b1efa6507ff457b'
key = 'af08266ff8187566de18395a562b294fd0b5a0bebbd93b9f011af4191b1636f1d42e9ca5063aa78e46ad858e6571b5dfe69ce601fd6d82354d5e0a518773bf11'

puts decrypt_session_cookie(cookie, key)
