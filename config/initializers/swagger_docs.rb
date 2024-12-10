Swagger::Docs::Config.register_apis('1.0' => {
                                      api_file_path: 'public/docs',
                                      base_path: 'http://localhost:3000',
                                      clean_directory: false,
                                      attributes: {
                                        info: {
                                          'title' => 'PUNTOSPOINT API',
                                          'description' => 'PUNTOSPOINT API documentation about ecommerce technical test',
                                          'termsOfServiceUrl' => 'https://www.puntospoint.com/terms-sample',
                                          'contact' => 'dantealonsoh@gmail.com',
                                          'license' => 'MIT',
                                          'licenseUrl' => 'https://opensource.org/licenses/MIT'
                                        }
                                      }
                                    })
