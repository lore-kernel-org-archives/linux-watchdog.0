Return-path: <rjw@rjwysocki.net>
From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
To: Fu Wei <fu.wei@linaro.org>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, Len Brown <lenb@kernel.org>, Daniel Lezcano <daniel.lezcano@linaro.org>, Thomas Gleixner <tglx@linutronix.de>, Marc Zyngier <marc.zyngier@arm.com>, Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>, Sudeep Holla <sudeep.holla@arm.com>, Hanjun Guo <hanjun.guo@linaro.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "linaro-acpi@lists.linaro.org" <linaro-acpi@lists.linaro.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, ACPI Devel Maling List <linux-acpi@vger.kernel.org>, rruigrok@codeaurora.org, harba@codeaurora.org, Christopher Covington <cov@codeaurora.org>, Timur Tabi <timur@codeaurora.org>, G Gregory <graeme.gregory@linaro.org>, Al Stone <al.stone@linaro.org>, Jon Masters <jcm@redhat.com>, wei@redhat.com, Arnd Bergmann <arnd@arndb.de>, Wim Van Sebroeck <wim@iguana.be>, Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will.deacon@arm.com>, Suravee Suthikulanit <Suravee.Suthikulpanit@amd.com>, Leo Duran <leo.duran@amd.com>, Guenter Roeck <linux@roeck-us.net>, "linux-watchdog@vger.kernel.org" <linux-watchdog@vger.kernel.org>, David Miller <davem@davemloft.net>, Andrew Morton <akpm@linux-foundation.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, kvalo@codeaurora.org, Jiri Slaby <jslaby@suse.cz>, Christoffer Dall <christoffer.dall@linaro.org>, Julien Grall <julien.grall@arm.com>
Subject: Re: [PATCH v7 4/9] acpi/arm64: Add GTDT table parse driver
Date: Fri, 15 Jul 2016 15:07:08 +0200
Message-ID: <5101961.eCg7ixLQWc@vostro.rjw.lan>
In-Reply-To: <1809117.TV1VJp2Xpr@vostro.rjw.lan>
References: <1468432402-4872-1-git-send-email-fu.wei@linaro.org> <CADyBb7tkk5DhG_1_87+BQKQfF-CSC+LgP7LE=9SmztvaFLxNyQ@mail.gmail.com> <1809117.TV1VJp2Xpr@vostro.rjw.lan>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="utf-8"
List-ID: <linux-watchdog@vger.kernel.org>

On Friday, July 15, 2016 02:15:27 PM Rafael J. Wysocki wrote:
> On Friday, July 15, 2016 03:32:35 PM Fu Wei wrote:
> > Hi Rafael,
> > 

[cut]

> > >
> > >> +               return 0;
> > >> +       }
> > >> +
> > >> +       if (!gtdt->platform_timer_count) {
> > >> +               pr_info("No Platform Timer.\n");
> > >> +               return 0;
> > >> +       }
> > >> +
> > >> +       acpi_gtdt_desc.platform_timer_start = (void *)gtdt +
> > >> +                                             gtdt->platform_timer_offset;
> > >> +       if (acpi_gtdt_desc.platform_timer_start <
> > >> +           (void *)table + sizeof(struct acpi_table_gtdt)) {
> > >> +               pr_err(FW_BUG "Platform Timer pointer error.\n");
> > >
> > > Why pr_err()?
> > 
> > if (true), that means the GTDT table has bugs.
> > 
> 
> And that's not a very useful piece of information unless you're debugging the
> platform, is it?

FWIW, I'm not a big fan of printing "your firmware is buggy" type of messages
(especially at the "error" log level or higher) unless they can be clearly
connected to a specific type of functional failure.

So if you want to pring an error-level message, something like "I cannot do X
because of the firmware bug Y" would be better IMO.

Thanks,
Rafael
