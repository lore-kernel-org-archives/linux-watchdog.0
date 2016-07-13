Return-path: <rjwysocki@gmail.com>
MIME-Version: 1.0
Sender: rjwysocki@gmail.com
In-Reply-To: <1468432402-4872-6-git-send-email-fu.wei@linaro.org>
References: <1468432402-4872-1-git-send-email-fu.wei@linaro.org> <1468432402-4872-6-git-send-email-fu.wei@linaro.org>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Wed, 13 Jul 2016 22:16:51 +0200
Message-ID: <CAJZ5v0gut2uCFHa7hr8iKY4ioP4q17yo=gBxJEeZf5WvVNM7pQ@mail.gmail.com>
Subject: Re: [PATCH v7 5/9] MAINTAINERS / ACPI: add the ARM64-specific ACPI
 Support maintainers
To: Hanjun Guo <hanjun.guo@linaro.org>, Fu Wei <fu.wei@linaro.org>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Len Brown <lenb@kernel.org>,
	Daniel Lezcano <daniel.lezcano@linaro.org>, Thomas Gleixner <tglx@linutronix.de>,
	Marc Zyngier <marc.zyngier@arm.com>, Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
	Sudeep Holla <sudeep.holla@arm.com>,
	"linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>,
	"linaro-acpi@lists.linaro.org" <linaro-acpi@lists.linaro.org>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	ACPI Devel Maling List <linux-acpi@vger.kernel.org>, rruigrok@codeaurora.org, harba@codeaurora.org,
	Christopher Covington <cov@codeaurora.org>, Timur Tabi <timur@codeaurora.org>,
	G Gregory <graeme.gregory@linaro.org>, Al Stone <al.stone@linaro.org>,
	Jon Masters <jcm@redhat.com>, wei@redhat.com, Arnd Bergmann <arnd@arndb.de>,
	Wim Van Sebroeck <wim@iguana.be>, Catalin Marinas <catalin.marinas@arm.com>,
	Will Deacon <will.deacon@arm.com>, Suravee Suthikulanit <Suravee.Suthikulpanit@amd.com>,
	Leo Duran <leo.duran@amd.com>, Guenter Roeck <linux@roeck-us.net>,
	"linux-watchdog@vger.kernel.org" <linux-watchdog@vger.kernel.org>, David Miller <davem@davemloft.net>,
	Andrew Morton <akpm@linux-foundation.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	kvalo@codeaurora.org, mchehab@kernel.org, Jiri Slaby <jslaby@suse.cz>,
	christoffer.dall@linaro.org, julien.grall@arm.com
Content-Type: text/plain; charset=UTF-8
List-ID: <linux-watchdog@vger.kernel.org>

On Wed, Jul 13, 2016 at 7:53 PM,  <fu.wei@linaro.org> wrote:
> From: Fu Wei <fu.wei@linaro.org>
>
> This patch add the ARM64-specific ACPI Support maintainers in
> MAINTAINERS, according to the discussion on mailing list:
> https://lkml.org/lkml/2016/6/29/580
> Lorenzo Pieralisi will submit the pull requsts.
>
> The maintainers are listed by the alphabet order of
> their name.
>
> Signed-off-by: Fu Wei <fu.wei@linaro.org>
> Signed-off-by: Hanjun Guo <hanjun.guo@linaro.org>
> ---
>  MAINTAINERS | 8 ++++++++
>  1 file changed, 8 insertions(+)
>
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 1209323..1e03463 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -315,6 +315,14 @@ W: https://01.org/linux-acpi
>  S:     Supported
>  F:     drivers/acpi/fan.c
>
> +ACPI FOR ARM64 (ACPI/arm64)
> +M:     Hanjun Guo <hanjun.guo@linaro.org>
> +M:     Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
> +M:     Sudeep Holla <sudeep.holla@arm.com>
> +L:     linux-acpi@vger.kernel.org
> +S:     Supported
> +F:     drivers/acpi/arm64
> +
>  ACPI THERMAL DRIVER
>  M:     Zhang Rui <rui.zhang@intel.com>
>  L:     linux-acpi@vger.kernel.org
> --

This patch should not be part of your series.

I would prefer it if  Hanjun, Lorenzo or Sudeep sent it.

Of course, it doesn't make much sense to send it before creating
drivers/acpi/arm64/ and putting something in there, so it should be
sent separately after the series has been merged.

Thanks,
Rafael
