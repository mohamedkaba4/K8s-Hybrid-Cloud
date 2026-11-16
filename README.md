# K8s-Nexus-Hybrid-Kubernetes-Fabric

# K8s Nexus Hybrid

Hybrid multi-cluster Kubernetes platform connecting the Mavencrest on-prem Kubernetes environment with Azure Kubernetes Service (AKS).

The project shows how independently managed Kubernetes clusters can operate as one logical hybrid platform using Azure Arc, GitOps, centralized governance, workload consistency, security controls, and cross-cluster failover.

## Architecture

    Git / GitOps

        |

        v

    +----------------------+----------------------+

    |                                             |

    v                                             v

    On-Prem Kubernetes                           AKS

    kubeadm cluster                              Azure Kubernetes Service

    |                                             |

    |                                             |

    +----------------------+----------------------+

                           |

                           v

                       Azure Arc

                           |

                           v

                Centralized Management

                           |

          +----------------+----------------+

          |                                 |

          v                                 v

    Policy / Governance             Workload Consistency

          |                                 |

          +----------------+----------------+

                           |

                           v

                  Shared Application

The on-prem cluster and AKS stay independent Kubernetes clusters, but are managed as part of a shared hybrid platform.

## Platform Goals

- Connect self-managed Kubernetes and AKS

- Register the on-prem Kubernetes cluster with Azure Arc

- Apply centralized policy and governance

- Maintain consistent configuration through GitOps

- Deploy the same logical workload across both environments

- Test active/passive and failover scenarios

- Explore multi-cluster workload placement

- Centralize observability and security controls

- Maintain environment-specific configuration where required

## Hybrid Workload Model

    Users

      |

      v

    Global Traffic Layer

      |

      +----------------------+

      |                      |

      v                      v

    AKS                   On-Prem

    Active                Standby

      |                      |

      +----------+-----------+

                 |

                 v

         Shared Application

The goal is not to merge AKS and on-prem into one Kubernetes cluster.

Instead, the platform uses two independent clusters that can host the same logical workload and support cross-cluster resiliency.

## Azure Arc

Azure Arc provides the management layer for bringing the on-prem Kubernetes cluster into Azure.

Planned capabilities include:

- Centralized governance

- Azure Policy

- GitOps configuration

- Cluster inventory

- Monitoring

- Security integration

- Consistent management across cloud and on-prem environments

## GitOps

Git acts as the source of truth for shared Kubernetes configuration.

    Git Repository

          |

          v

       Argo CD

          |

          +------------------+

          |                  |

          v                  v

    On-Prem Cluster         AKS

Shared Kubernetes configuration can be deployed to both clusters while maintaining separate Helm values or environment-specific overlays where needed.

## High Availability and Failover

The long-term objective is to test workload resiliency across cloud and on-prem environments.

Normal state:

    Users

      |

      v

    AKS

      |

      v

    Application

    On-Prem

    Standby

Failover state:

    AKS unavailable

          |

          v

    Traffic redirected

          |

          v

       On-Prem

          |

          v

     Application

Planned testing includes:

- Cluster failure

- Node failure

- Application failure

- Traffic redirection

- Workload recovery

- Configuration drift

- GitOps recovery

- Database availability

- Cross-cluster workload consistency

## Security

Security is a major design focus of K8s Nexus Hybrid.

The platform will use layered controls across both Kubernetes environments, including:

- Kubernetes NetworkPolicy

- Cilium microsegmentation

- Least-privilege access

- Azure Policy

- Azure RBAC

- Workload identity

- Centralized secrets management

- Controlled service-to-service communication

- Default-deny workload networking where appropriate

The objective is to reduce lateral movement and limit the blast radius of a compromised workload across both clusters.

Example:

    Frontend

       |

       +------> User Service

       |

       +------> Balance Service

       |

       X------> Database

    Unauthorized Pod

       |

       X------> Internal Services

## Platform Stack

- Kubernetes

- AKS

- kubeadm

- Azure Arc

- Terraform

- Argo CD

- Helm

- Cilium

- Azure Policy

- Azure RBAC

- Prometheus

- Grafana

- GitHub Actions / Azure DevOps

- Cloudflare / global traffic routing

## Relationship to Existing Projects

### Mavencrest On-Prem Kubernetes

Focuses on self-managed Kubernetes fundamentals and operations:

- kubeadm

- containerd

- worker nodes

- Flannel

- pod networking

- persistent storage

- Cloudflare Tunnel

- Prometheus

- Grafana

- node and workload troubleshooting

### AKS Mavencrest Platform

Focuses on managed Kubernetes and Azure-native platform engineering:

- AKS

- Azure networking

- Azure CNI

- Cilium

- microservices

- Argo CD

- Helm

- autoscaling

- Azure Container Registry

- Azure identity

- observability

- microsegmentation

### K8s Nexus Hybrid

Connects both environments into a shared hybrid operating model.

The project focuses on:

- hybrid Kubernetes management

- Azure Arc

- multi-cluster GitOps

- shared policy

- workload portability

- cross-cluster failover

- centralized security

- centralized observability

## Project Objective

K8s Nexus Hybrid demonstrates the progression from operating individual Kubernetes environments to engineering a hybrid multi-cluster platform including on-prem and cloud workloads.

The final architecture is intended to show that the same logical workload can be securely deployed, governed, observed, and recovered across both self-managed Kubernetes and Azure Kubernetes Service.
