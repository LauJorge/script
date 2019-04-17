3d5a6874-14fa-4416-9023-4864ef89b4b8


;WVqh!K2V9?P7-GS2zgzlWIGKfF%GtLo

92I2h.mYu))y4E3OV42B8XJiI?KDxv3J

arn:aws:iam::169496270936:role/lau-CrossAccountRoles-ET94G0TUWVDQ
            "id": "b32e0b3e-fe35-4fbc-aae1-e580728000d3",

	
02551538-665b-4d0b-b144-c947ae22cbfd

Network: vpc-0770200073c8c1fc5 | Sources and Targets

Subnet: subnet-0856052b7c515a9b6 | targets02-private | us-east-2b

sg-001705b7f25b47317


"entitlement": "98084572-bb38-4f00-82e4-4c1f9785883b"



------------------------
{
  "name": "Automation Nightly",
  "suite_run_name": "ME_RUN",
  "create_only": false,
  "serial_execution": false,
  "global_config": {
    "testbed": {
      "url": "http://plb01.qa-auto1.rmsvcs.net",
      "email": "fernando.martinez@globallogic.com",
      "password": "xxx",
      "entitlement": "b32e0b3e-fe35-4fbc-aae1-e580728000d3"
    },
    "config1": {
      "ca": {
        "cloud_account_config": {
          "url": "https://aws.amazon.com",
          "tenant_id": "n/a",
          "name": "alex-automation-test-1",
          "auth": {
            "auth_type": "role",
            "credentials": {
              "role_arn": "arn:aws:iam::169496270936:role/lau-CrossAccountRoles-ET94G0TUWVDQ",
              "external_id": "02551538-665b-4d0b-b144-c947ae22cbfd"
            }
          },
          "type": "aws"
        },
        "appliance_config": {
          "cloud_properties": {
            "region": "us-east-2",
            "vapp_name": "",
            "vpc": "vpc-0770200073c8c1fc5",
            "az": "us-east-2b",
            "tags": {
            },
            "network": {
              "interfaces": {
                "eth0": {
                  "ip_type": "dhcp",
                  "type": "Ethernet",
                  "network_name": "subnet-0856052b7c515a9b6",
                  "assign_public_ip": true
                }
              }
            },
            "proxy_type": "none"
          }
        },
        "retries_max": 20,
        "retries_interval_sec": 60
      },
      "source": {
        "source_config": {
          "name": "",
          "host": "",
          "tags": [
          ],
          "instructions": {
          },
          "credentials": {
            "storage": "local",
            "username": "administrator",
            "password": "qatesting220!",
            "domain": ""
          }
        },
        "preflight_options": {
          "appliance_id": "",
          "cloud_account": "",
          "cloud_type": "aws",
          "is_data_only": false
        },
        "retries_max": 10,
        "retries_interval_sec": 30
      },
      "full_migration": {
        "migration_config": {
          "name": "",
          "tags": [
          ],
          "entitlement": "",
          "cloud_account": "",
          "is_data_only": false,
          "appliance_id": "",
          "schedule": null,
          "sources": [
            {
              "source": "",
              "target_config": {
                "vm_details": {
                  "vapp_name": "",
                  "tags": {
                  },
                  "flavor": {
                    "flavor_type": "t2.medium",
                    "volume_type": "ssd",
                    "iops": null
                  },
                  "security": {
                    "vpc_id": "vpc-0770200073c8c1fc5",
                    "security_group_ids": [
                      "sg-001705b7f25b47317"
                    ]
                  },
                  "encrypt_volumes": false,
                  "capture_ami": false
                },
                "properties": {
                  "network": {
                    "interfaces": {
                      "eth0": {
                        "ip_type": "dhcp",
                        "type": "Ethernet",
                        "network_name": "subnet-0856052b7c515a9b6",
                        "assign_public_ip": true
                      }
                    }
                  },
                  "selected_mounts": [
                    {
                      "mount_point": "C"
                    }
                  ],
                  "name": ""
                },
                "options": {
                  "region": "us-east-2",
                  "az": "us-east-2b",
                  "power_on": true,
                  "tenancy": "default",
                  "affinity": null,
                  "tenant_id": null,
                  "host_id": null
                }
              },
              "verify_ssl_certificates": true,
              "publish_migration_hub": false,
              "migration_instructions": {},
              "ignore_validation_errors": false,
              "preflight_warning": true
            }
          ]
        },
        "retries_max": 60,
        "retries_interval_sec": 60
      },
      "dm_migration": {
        "dm_config": {
          "name": "",
          "entitlement": "",
          "description": null,
          "appliance_id": "",
          "schedule": null,
          "differential_configs": [
            {
              "migration": "",
              "schedule": null,
              "target": {
              },
              "source": {
              },
              "shutdown_source": false,
              "publish_migration_hub": false,
              "target_properties": {
                "additional_disks": {
                },
                "network": {
                  "public_ip_address": "",
                  "interfaces": {
                    "eth0": {
                      "type": "Ethernet",
                      "assign_public_ip": true,
                      "ip_type": "dhcp",
                      "network_name": "",
                      "current_security_group": ""
                    }
                  },
                  "network_names": [
                  ],
                  "security_group": "",
                  "dns": null,
                  "routes": null
                },
                "migration_network": null,
                "migration_type": "",
                "selected_mounts": {
                  "/": {
                    "includes": [
                    ],
                    "excludes": [
                    ]
                  }
                },
                "validate": false,
                "name": ""
              },
              "migration_instructions": {},
              "target_ip": ""
            }
          ]
        }
      }
    }
  },
  "scenarios_config": {
    "ca1": {
      "ca_config": {
        "global_config_key": "config1"
      },
      "scenarios": [
        {
          "name": "Full, DM, succeeds",
          "scenario_id": "full_and_dm",
          "scenario_config": {
            "source_host": "10.54.6.100",
            "source_name": "",
            "selected_mounts": [
              "C", "F"
            ],
            "dm_selected_mounts": ["C","F"]
          }
        }
      ]
    }
  }
}


{
    "CLOUD_ACCOUNT_NAME": "LauraCloud11",
    "ENTITLEMENTS": "98084572-bb38-4f00-82e4-4c1f9785883b",
    "FULL_DM_SCENARIO_ID": "09f849f3-1238-4990-af04-0bd44c51f58c",
    "LAST_AUTOMATION_RUN": "35dd5807-859c-4358-9192-294a85fe35ea",
    "SOURCE_IP": "10.54.6.100",
    "SUITE_RUN_NAME": "LauraSuite11",
    "TEMPLATE_NAME": "../templates/windows-aws-full-dm.json",
    "TEST_BED": ""
}

            "id": "22ca882c-820e-4ec9-b2e3-fc915b2f6652",
