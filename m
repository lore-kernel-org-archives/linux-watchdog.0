Return-path: <tglx@linutronix.de>
Date: Tue, 6 Sep 2016 16:36:25 +0200 (CEST)
From: Thomas Gleixner <tglx@linutronix.de>
To: Fu Wei <fu.wei@linaro.org>
cc: rjw@rjwysocki.net, lenb@kernel.org, daniel.lezcano@linaro.org,
    marc.zyngier@arm.com, lorenzo.pieralisi@arm.com, sudeep.holla@arm.com,
    hanjun.guo@linaro.org, linux-arm-kernel@lists.infradead.org,
    linaro-acpi@lists.linaro.org, linux-kernel@vger.kernel.org,
    linux-acpi@vger.kernel.org, rruigrok@codeaurora.org, harba@codeaurora.org,
    cov@codeaurora.org, timur@codeaurora.org, graeme.gregory@linaro.org,
    al.stone@linaro.org, jcm@redhat.com, wei@redhat.com, arnd@arndb.de,
    wim@iguana.be, catalin.marinas@arm.com, will.deacon@arm.com,
    Suravee.Suthikulpanit@amd.com, leo.duran@amd.com, linux@roeck-us.net,
    linux-watchdog@vger.kernel.org
Subject: Re: [PATCH v11 5/8] clocksource/drivers/arm_arch_timer: Simplify
 ACPI support code.
In-Reply-To: <1473168352-5156-6-git-send-email-fu.wei@linaro.org>
Message-ID: <alpine.DEB.2.20.1609061635000.5647@nanos>
References: <1473168352-5156-1-git-send-email-fu.wei@linaro.org> <1473168352-5156-6-git-send-email-fu.wei@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
List-ID: <linux-watchdog@vger.kernel.org>

On Tue, 6 Sep 2016, fu.wei@linaro.org wrote:
> +	if (timer_count < 0)
> +		pr_err("Failed to get platform timer info, skipping.\n");

So this prints something about skipping. But then it continues as if
nothing went wrong. That's either wrong or confusing or both.

> -	arch_timer_init();
> -	return 0;
> +	return arch_timer_init();

Thanks,

	tglx
