Return-Path: <linux-kernel-owner@vger.kernel.org>
Date: Sat, 15 Mar 2014 21:04:15 +0100
From: Wim Van Sebroeck <wim@iguana.be>
To: Peter Tyser <ptyser@xes-inc.com>
Cc: linux-kernel@vger.kernel.org, Guenter Roeck <linux@roeck-us.net>,
        James Ralston <james.d.ralston@intel.com>,
        Samuel Ortiz <sameo@linux.intel.com>, Lee Jones <lee.jones@linaro.org>,
        linux-watchdog@vger.kernel.org
Subject: Re: [PATCH 4/8] mfd: lpc_ich: Add support for iTCO v3
Message-ID: <20140315200415.GD14815@spo001.leaseweb.com>
References: <1394487298-14459-1-git-send-email-ptyser@xes-inc.com> <1394487298-14459-4-git-send-email-ptyser@xes-inc.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1394487298-14459-4-git-send-email-ptyser@xes-inc.com>
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/lkml/>
List-Post: <mailto:linux-kernel@vger.kernel.org>
List-ID: <linux-watchdog@vger.kernel.org>

Hi Peter,

> Some newer Atom CPUs, eg Avoton and Bay Trail, use slightly different
> register layouts for the iTCO than the current v1 and v2 iTCO.
> Differences from previous iTCO versions include:
> - The ACPI space is enabled in the "ACPI base address" register instead
>   of the "ACPI control register"
> 
> - The "no reboot" functionality is set in the "Power Management
>   Configuration" register instead of the "General Control and Status"
>   (GCS) register or PCI configuration space.
> 
> - The "ACPI Control Register" is not present on v3.  The "Power
>   Management Configuration Base Address" register resides at the same
>   address is Avoton/Bay Trail.
> 
> To differentiate these newer chipsets create a new v3 iTCO version and
> update the MFD driver to support them.
> 
> Signed-off-by: Peter Tyser <ptyser@xes-inc.com>
> Tested-by: Rajat Jain <rajatjain@juniper.net>
> Cc: Guenter Roeck <linux@roeck-us.net>
> Cc: James Ralston <james.d.ralston@intel.com>
> Cc: Samuel Ortiz <sameo@linux.intel.com>
> Cc: Lee Jones <lee.jones@linaro.org>
> Cc: Wim Van Sebroeck <wim@iguana.be>
> Cc: linux-watchdog@vger.kernel.org
> ---
>  drivers/mfd/lpc_ich.c       |   81 +++++++++++++++++++++++++++++++++++-------
>  include/linux/mfd/lpc_ich.h |    8 ++--
>  2 files changed, 71 insertions(+), 18 deletions(-)
> 

Acked-by: Wim Van Sebroeck <wim@iguana.be>

Kind regards,
Wim.
