Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from mail-ie0-f178.google.com ([209.85.223.178]:40356 "EHLO
	mail-ie0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751797AbbCIWeN convert rfc822-to-8bit (ORCPT
	<rfc822;linux-watchdog@vger.kernel.org>);
	Mon, 9 Mar 2015 18:34:13 -0400
Received: by iecrp18 with SMTP id rp18so39689529iec.7
        for <linux-watchdog@vger.kernel.org>; Mon, 09 Mar 2015 15:34:12 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8BIT
To: Boris Brezillon <boris.brezillon@free-electrons.com>,
	"Thomas Gleixner" <tglx@linutronix.de>,
	"Jason Cooper" <jason@lakedaemon.net>,
	"Peter Zijlstra" <peterz@infradead.org>,
	"Mark Rutland" <mark.rutland@arm.com>,
	"Rafael J. Wysocki" <rjw@rjwysocki.net>
From: Mike Turquette <mturquette@linaro.org>
In-Reply-To: <1425287898-15093-5-git-send-email-boris.brezillon@free-electrons.com>
Cc: "Len Brown" <len.brown@intel.com>, "Pavel Machek" <pavel@ucw.cz>,
	linux-pm@vger.kernel.org, "Wim Van Sebroeck" <wim@iguana.be>,
	linux-watchdog@vger.kernel.org,
	"Alessandro Zummo" <a.zummo@towertech.it>,
	rtc-linux@googlegroups.com,
	"Greg Kroah-Hartman" <gregkh@linuxfoundation.org>,
	"Jiri Slaby" <jslaby@suse.cz>, linux-serial@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	"Nicolas Ferre" <nicolas.ferre@atmel.com>,
	"Jean-Christophe Plagniol-Villard" <plagnioj@jcrosoft.com>,
	"Alexandre Belloni" <alexandre.belloni@free-electrons.com>,
	linux-arm-kernel@lists.infradead.org,
	"Boris Brezillon" <boris.brezillon@free-electrons.com>
References: <1425287898-15093-1-git-send-email-boris.brezillon@free-electrons.com>
 <1425287898-15093-5-git-send-email-boris.brezillon@free-electrons.com>
Message-ID: <20150309223406.14952.5669@quantum>
Subject: Re: [PATCH v2 4/6] clk: at91: implement suspend/resume for the PMC irqchip
Date: Mon, 09 Mar 2015 15:34:06 -0700
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

Quoting Boris Brezillon (2015-03-02 01:18:16)
> The irq line used by the PMC block is shared with several peripherals
> including the init timer which is registering its handler with
> IRQF_NO_SUSPEND.
> Implement the appropriate suspend/resume callback for the PMC irqchip,
> and inform irq core that PMC irq handler can be safely called while
> the system is suspended by setting IRQF_COND_SUSPEND.
> 
> Signed-off-by: Boris Brezillon <boris.brezillon@free-electrons.com>

Looks OK to me. I'm not picking it due to the dependency you listed in
the cover letter.

Regards,
Mike

> ---
>  drivers/clk/at91/pmc.c | 20 +++++++++++++++++++-
>  drivers/clk/at91/pmc.h |  1 +
>  2 files changed, 20 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/clk/at91/pmc.c b/drivers/clk/at91/pmc.c
> index f07c815..3f27d21 100644
> --- a/drivers/clk/at91/pmc.c
> +++ b/drivers/clk/at91/pmc.c
> @@ -89,12 +89,29 @@ static int pmc_irq_set_type(struct irq_data *d, unsigned type)
>         return 0;
>  }
>  
> +static void pmc_irq_suspend(struct irq_data *d)
> +{
> +       struct at91_pmc *pmc = irq_data_get_irq_chip_data(d);
> +
> +       pmc->imr = pmc_read(pmc, AT91_PMC_IMR);
> +       pmc_write(pmc, AT91_PMC_IDR, pmc->imr);
> +}
> +
> +static void pmc_irq_resume(struct irq_data *d)
> +{
> +       struct at91_pmc *pmc = irq_data_get_irq_chip_data(d);
> +
> +       pmc_write(pmc, AT91_PMC_IER, pmc->imr);
> +}
> +
>  static struct irq_chip pmc_irq = {
>         .name = "PMC",
>         .irq_disable = pmc_irq_mask,
>         .irq_mask = pmc_irq_mask,
>         .irq_unmask = pmc_irq_unmask,
>         .irq_set_type = pmc_irq_set_type,
> +       .irq_suspend = pmc_irq_suspend,
> +       .irq_resume = pmc_irq_resume,
>  };
>  
>  static struct lock_class_key pmc_lock_class;
> @@ -224,7 +241,8 @@ static struct at91_pmc *__init at91_pmc_init(struct device_node *np,
>                 goto out_free_pmc;
>  
>         pmc_write(pmc, AT91_PMC_IDR, 0xffffffff);
> -       if (request_irq(pmc->virq, pmc_irq_handler, IRQF_SHARED, "pmc", pmc))
> +       if (request_irq(pmc->virq, pmc_irq_handler,
> +                       IRQF_SHARED | IRQF_COND_SUSPEND, "pmc", pmc))
>                 goto out_remove_irqdomain;
>  
>         return pmc;
> diff --git a/drivers/clk/at91/pmc.h b/drivers/clk/at91/pmc.h
> index 52d2041..69abb08 100644
> --- a/drivers/clk/at91/pmc.h
> +++ b/drivers/clk/at91/pmc.h
> @@ -33,6 +33,7 @@ struct at91_pmc {
>         spinlock_t lock;
>         const struct at91_pmc_caps *caps;
>         struct irq_domain *irqdomain;
> +       u32 imr;
>  };
>  
>  static inline void pmc_lock(struct at91_pmc *pmc)
> -- 
> 1.9.1
> 
