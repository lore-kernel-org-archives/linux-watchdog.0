Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from foss.arm.com ([217.140.101.70]:58526 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753372AbdDRP7L (ORCPT <rfc822;linux-watchdog@vger.kernel.org>);
        Tue, 18 Apr 2017 11:59:11 -0400
Date: Tue, 18 Apr 2017 16:58:41 +0100
From: Mark Rutland <mark.rutland@arm.com>
To: fu.wei@linaro.org, rjw@rjwysocki.net, lenb@kernel.org,
        lorenzo.pieralisi@arm.com, hanjun.guo@linaro.org
Cc: daniel.lezcano@linaro.org, tglx@linutronix.de,
        marc.zyngier@arm.com, sudeep.holla@arm.com,
        linux-arm-kernel@lists.infradead.org, linaro-acpi@lists.linaro.org,
        linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org,
        rruigrok@codeaurora.org, harba@codeaurora.org, cov@codeaurora.org,
        timur@codeaurora.org, graeme.gregory@linaro.org,
        al.stone@linaro.org, jcm@redhat.com, wei@redhat.com, arnd@arndb.de,
        catalin.marinas@arm.com, will.deacon@arm.com,
        Suravee.Suthikulpanit@amd.com, leo.duran@amd.com, wim@iguana.be,
        linux@roeck-us.net, linux-watchdog@vger.kernel.org,
        tn@semihalf.com, christoffer.dall@linaro.org, julien.grall@arm.com
Subject: Re: [PATCH v24 08/11] acpi: Introduce acpi_unregister_irq function
Message-ID: <20170418155841.GK17866@leverpostej>
References: <20170414184014.8524-1-fu.wei@linaro.org>
 <20170414184014.8524-9-fu.wei@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20170414184014.8524-9-fu.wei@linaro.org>
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

On Sat, Apr 15, 2017 at 02:40:11AM +0800, fu.wei@linaro.org wrote:
> From: Fu Wei <fu.wei@linaro.org>
> 
> This patch introduces acpi_unregister_irq function to free a
> linux IRQ number<->GSI mapping by a given linux IRQ number.
> 
> Even we have successfully registered the GSI, when some error occurs, we
> may need to unmap it for freeing the IRQ resource. But in some cases, we
> only have IRQ, but not GSI.
> 
> This patch is the preparation for memory-mapped timer support in GTDT
> driver.
> 
> Signed-off-by: Fu Wei <fu.wei@linaro.org>
> ---
>  drivers/acpi/irq.c   | 10 ++++++++++
>  include/linux/acpi.h |  7 +++++++
>  2 files changed, 17 insertions(+)

This will need comments/acks from the ACPI folk.

Lorenzo, do you prefer this to direct use of irq_dispose_mapping() in
the GTDT parsing code?

Thanks,
Mark.

> diff --git a/drivers/acpi/irq.c b/drivers/acpi/irq.c
> index 830299a..59de777 100644
> --- a/drivers/acpi/irq.c
> +++ b/drivers/acpi/irq.c
> @@ -85,6 +85,16 @@ void acpi_unregister_gsi(u32 gsi)
>  EXPORT_SYMBOL_GPL(acpi_unregister_gsi);
>  
>  /**
> + * acpi_unregister_irq() - Free a linux IRQ number<->GSI mapping
> + * @irq: linux IRQ number
> + */
> +void acpi_unregister_irq(int irq)
> +{
> +	irq_dispose_mapping(irq);
> +}
> +EXPORT_SYMBOL_GPL(acpi_unregister_irq);
> +
> +/**
>   * acpi_get_irq_source_fwhandle() - Retrieve fwhandle from IRQ resource source.
>   * @source: acpi_resource_source to use for the lookup.
>   *
> diff --git a/include/linux/acpi.h b/include/linux/acpi.h
> index 4b5c146..728d1ed 100644
> --- a/include/linux/acpi.h
> +++ b/include/linux/acpi.h
> @@ -336,6 +336,13 @@ extern int acpi_get_override_irq(u32 gsi, int *trigger, int *polarity);
>   */
>  void acpi_unregister_gsi (u32 gsi);
>  
> +/*
> + * This function undoes the effect of one call to acpi_register_gsi().
> + * The irq should be the return value of acpi_register_gsi().
> + * If the irq is valid, free a linux IRQ number<->GSI mapping.
> + */
> +void acpi_unregister_irq(int irq);
> +
>  struct pci_dev;
>  
>  int acpi_pci_irq_enable (struct pci_dev *dev);
> -- 
> 2.9.3
> 
