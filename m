Return-path: <mark.rutland@arm.com>
Date: Thu, 20 Oct 2016 16:09:33 +0100
From: Mark Rutland <mark.rutland@arm.com>
To: fu.wei@linaro.org
Cc: rjw@rjwysocki.net, lenb@kernel.org, daniel.lezcano@linaro.org,
	tglx@linutronix.de, marc.zyngier@arm.com, lorenzo.pieralisi@arm.com,
	sudeep.holla@arm.com, hanjun.guo@linaro.org,
	linux-arm-kernel@lists.infradead.org, linaro-acpi@lists.linaro.org,
	linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org,
	rruigrok@codeaurora.org, harba@codeaurora.org, cov@codeaurora.org,
	timur@codeaurora.org, graeme.gregory@linaro.org,
	al.stone@linaro.org, jcm@redhat.com, wei@redhat.com, arnd@arndb.de,
	catalin.marinas@arm.com, will.deacon@arm.com,
	Suravee.Suthikulpanit@amd.com, leo.duran@amd.com, wim@iguana.be,
	linux@roeck-us.net, linux-watchdog@vger.kernel.org, tn@semihalf.com,
	christoffer.dall@linaro.org, julien.grall@arm.com
Subject: Re: [PATCH v14 2/9] clocksource/drivers/arm_arch_timer: Add a new
 enum for spi type
Message-ID: <20161020150933.GK10234@leverpostej>
References: <1475086637-1914-1-git-send-email-fu.wei@linaro.org>
 <1475086637-1914-3-git-send-email-fu.wei@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1475086637-1914-3-git-send-email-fu.wei@linaro.org>
List-ID: <linux-watchdog@vger.kernel.org>

On Thu, Sep 29, 2016 at 02:17:10AM +0800, fu.wei@linaro.org wrote:
> diff --git a/include/clocksource/arm_arch_timer.h b/include/clocksource/arm_arch_timer.h
> index 6f06481..16dcd10 100644
> --- a/include/clocksource/arm_arch_timer.h
> +++ b/include/clocksource/arm_arch_timer.h
> @@ -45,6 +45,12 @@ enum ppi_nr {
>  	MAX_TIMER_PPI
>  };
>  
> +enum spi_nr {
> +	PHYS_SPI,
> +	VIRT_SPI,
> +	MAX_TIMER_SPI
> +};

Please rename this to arch_timer_spi_nr (as with patch 1 for
s/ppi_nr/arch_timer_ppi_nr/). With that:

Acked-by: Mark Rutland <mark.rutland@arm.com>

Thanks,
Mark.
