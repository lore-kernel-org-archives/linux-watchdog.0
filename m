Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from mail-pf0-f169.google.com ([209.85.192.169]:36651 "EHLO
        mail-pf0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751303AbdASJMB (ORCPT
        <rfc822;linux-watchdog@vger.kernel.org>);
        Thu, 19 Jan 2017 04:12:01 -0500
Received: by mail-pf0-f169.google.com with SMTP id 189so12133525pfu.3
        for <linux-watchdog@vger.kernel.org>; Thu, 19 Jan 2017 01:12:01 -0800 (PST)
Subject: Re: [PATCH v20 13/17] acpi/arm64: Add GTDT table parse driver
To: fu.wei@linaro.org, rjw@rjwysocki.net, lenb@kernel.org,
        daniel.lezcano@linaro.org, tglx@linutronix.de,
        marc.zyngier@arm.com, mark.rutland@arm.com,
        lorenzo.pieralisi@arm.com, sudeep.holla@arm.com
References: <20170118132541.8989-1-fu.wei@linaro.org>
 <20170118132541.8989-14-fu.wei@linaro.org>
Cc: linux-arm-kernel@lists.infradead.org, linaro-acpi@lists.linaro.org,
        linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org,
        rruigrok@codeaurora.org, harba@codeaurora.org, cov@codeaurora.org,
        timur@codeaurora.org, graeme.gregory@linaro.org,
        al.stone@linaro.org, jcm@redhat.com, wei@redhat.com, arnd@arndb.de,
        catalin.marinas@arm.com, will.deacon@arm.com,
        Suravee.Suthikulpanit@amd.com, leo.duran@amd.com, wim@iguana.be,
        linux@roeck-us.net, linux-watchdog@vger.kernel.org,
        tn@semihalf.com, christoffer.dall@linaro.org, julien.grall@arm.com
From: Hanjun Guo <hanjun.guo@linaro.org>
Message-ID: <e69d80d1-0954-b1be-817e-c0be6fc24b77@linaro.org>
Date: Thu, 19 Jan 2017 17:11:29 +0800
MIME-Version: 1.0
In-Reply-To: <20170118132541.8989-14-fu.wei@linaro.org>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

On 2017/1/18 21:25, fu.wei@linaro.org wrote:
> From: Fu Wei <fu.wei@linaro.org>
>
> This patch adds support for parsing arch timer info in GTDT,
> provides some kernel APIs to parse all the PPIs and
> always-on info in GTDT and export them.
>
> By this driver, we can simplify arm_arch_timer drivers, and
> separate the ACPI GTDT knowledge from it.
>
> Signed-off-by: Fu Wei <fu.wei@linaro.org>
> Signed-off-by: Hanjun Guo <hanjun.guo@linaro.org>
> Acked-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> Tested-by: Xiongfeng Wang <wangxiongfeng2@huawei.com>
> ---
>  arch/arm64/Kconfig          |   1 +
>  drivers/acpi/arm64/Kconfig  |   3 +
>  drivers/acpi/arm64/Makefile |   1 +
>  drivers/acpi/arm64/gtdt.c   | 157 ++++++++++++++++++++++++++++++++++++++++++++
>  include/linux/acpi.h        |   6 ++
>  5 files changed, 168 insertions(+)
>
> diff --git a/arch/arm64/Kconfig b/arch/arm64/Kconfig
> index 1117421..ab1ee10 100644
> --- a/arch/arm64/Kconfig
> +++ b/arch/arm64/Kconfig
> @@ -2,6 +2,7 @@ config ARM64
>  	def_bool y
>  	select ACPI_CCA_REQUIRED if ACPI
>  	select ACPI_GENERIC_GSI if ACPI
> +	select ACPI_GTDT if ACPI
>  	select ACPI_REDUCED_HARDWARE_ONLY if ACPI
>  	select ACPI_MCFG if ACPI
>  	select ACPI_SPCR_TABLE if ACPI
> diff --git a/drivers/acpi/arm64/Kconfig b/drivers/acpi/arm64/Kconfig
> index 4616da4..5a6f80f 100644
> --- a/drivers/acpi/arm64/Kconfig
> +++ b/drivers/acpi/arm64/Kconfig
> @@ -4,3 +4,6 @@
>
>  config ACPI_IORT
>  	bool
> +
> +config ACPI_GTDT
> +	bool
> diff --git a/drivers/acpi/arm64/Makefile b/drivers/acpi/arm64/Makefile
> index 72331f2..1017def 100644
> --- a/drivers/acpi/arm64/Makefile
> +++ b/drivers/acpi/arm64/Makefile
> @@ -1 +1,2 @@
>  obj-$(CONFIG_ACPI_IORT) 	+= iort.o
> +obj-$(CONFIG_ACPI_GTDT) 	+= gtdt.o
> diff --git a/drivers/acpi/arm64/gtdt.c b/drivers/acpi/arm64/gtdt.c
> new file mode 100644
> index 0000000..d93a790
> --- /dev/null
> +++ b/drivers/acpi/arm64/gtdt.c
> @@ -0,0 +1,157 @@
[...]
> +
> +/**
> + * acpi_gtdt_init() - Get the info of GTDT table to prepare for further init.
> + * @table:	The pointer to GTDT table.
> + * @platform_timer_count:	The pointer of int variate for returning the
> + *				number of platform timers. It can be NULL, if
> + *				driver don't need this info.
> + *
> + * Return: 0 if success, -EINVAL if error.
> + */
> +int __init acpi_gtdt_init(struct acpi_table_header *table,
> +			  int *platform_timer_count)
> +{
> +	int ret = 0;
> +	int timer_count = 0;
> +	void *platform_timer = NULL;
> +	struct acpi_table_gtdt *gtdt;
> +
> +	gtdt = container_of(table, struct acpi_table_gtdt, header);
> +	acpi_gtdt_desc.gtdt = gtdt;
> +	acpi_gtdt_desc.gtdt_end = (void *)table + table->length;
> +
> +	if (table->revision < 2)
> +		pr_debug("Revision:%d doesn't support Platform Timers.\n",
> +			 table->revision);

GTDT table revision is updated to 2 in ACPI 5.1, we will
not support ACPI version under 5.1 and disable ACPI in FADT
parse before this code is called, so if we get revision
<2 here, I think we need to print warning (we need to keep
the firmware stick to the spec on ARM64).

> +	else if (!gtdt->platform_timer_count)
> +		pr_debug("No Platform Timer.\n");
> +	else
> +		timer_count = gtdt->platform_timer_count;
> +
> +	if (timer_count) {
> +		platform_timer = (void *)gtdt + gtdt->platform_timer_offset;
> +		if (platform_timer < (void *)table +
> +				     sizeof(struct acpi_table_gtdt)) {
> +			pr_err(FW_BUG "invalid timer data.\n");

It's ok but I didn't see other ACPI tables parsing did this check,
maybe we can just remove it :)

> +			timer_count = 0;
> +			platform_timer = NULL;
> +			ret = -EINVAL;
> +		}
> +	}
> +
> +	acpi_gtdt_desc.platform_timer = platform_timer;
> +	if (platform_timer_count)
> +		*platform_timer_count = timer_count;

Then the code will much simple:

if (gtdt->platform_timer_count) {
	acpi_gtdt_desc.platform_timer = (void *)gtdt + gtdt->platform_timer_offset;
	if (platform_timer_count)
		*platform_timer_count = gtdt->platform_timer_count;
}

return 0;

and remove ret, timer_count and platform_timer.

Thanks
Hanjun
