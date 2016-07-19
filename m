Return-path: <fu.wei@linaro.org>
MIME-Version: 1.0
In-Reply-To: <16716612.zdLA2RMyjn@vostro.rjw.lan>
References: <1468432402-4872-1-git-send-email-fu.wei@linaro.org>
 <1580087.dlcVOb6fx1@vostro.rjw.lan> <CADyBb7tLyABzWFEW_8A3bK9XeWiHJjh7TqWQc=vDn5O_WUJX5w@mail.gmail.com>
 <16716612.zdLA2RMyjn@vostro.rjw.lan>
From: Fu Wei <fu.wei@linaro.org>
Date: Wed, 20 Jul 2016 02:25:35 +0800
Message-ID: <CADyBb7uiu2d-6bkA6qg9rWCePrZPtv3aMktXUvn7UciiR-WLhA@mail.gmail.com>
Subject: Re: [PATCH v7 4/9] acpi/arm64: Add GTDT table parse driver
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, Len Brown <lenb@kernel.org>,
	Daniel Lezcano <daniel.lezcano@linaro.org>, Thomas Gleixner <tglx@linutronix.de>,
	Marc Zyngier <marc.zyngier@arm.com>, Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
	Sudeep Holla <sudeep.holla@arm.com>, Hanjun Guo <hanjun.guo@linaro.org>,
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
	kvalo@codeaurora.org, Jiri Slaby <jslaby@suse.cz>,
	Christoffer Dall <christoffer.dall@linaro.org>, Julien Grall <julien.grall@arm.com>
Content-Type: text/plain; charset=UTF-8
List-ID: <linux-watchdog@vger.kernel.org>

Hi Rafael,

On 16 July 2016 at 20:35, Rafael J. Wysocki <rjw@rjwysocki.net> wrote:
> On Saturday, July 16, 2016 10:24:35 AM Fu Wei wrote:
>> Hi Rafeal,
>>
>> On 16 July 2016 at 05:22, Rafael J. Wysocki <rjw@rjwysocki.net> wrote:
>> > On Saturday, July 16, 2016 12:32:14 AM Fu Wei wrote:
>> >> Hi Rafael,
>> >>
>> >> On 15 July 2016 at 21:07, Rafael J. Wysocki <rjw@rjwysocki.net> wrote:
>> >> > On Friday, July 15, 2016 02:15:27 PM Rafael J. Wysocki wrote:
>> >> >> On Friday, July 15, 2016 03:32:35 PM Fu Wei wrote:
>> >> >> > Hi Rafael,
>> >> >> >
>> >> >
>> >> > [cut]
>> >> >
>> >> >> > >
>> >> >> > >> +               return 0;
>> >> >> > >> +       }
>> >> >> > >> +
>> >> >> > >> +       if (!gtdt->platform_timer_count) {
>> >> >> > >> +               pr_info("No Platform Timer.\n");
>> >> >> > >> +               return 0;
>> >> >> > >> +       }
>> >> >> > >> +
>> >> >> > >> +       acpi_gtdt_desc.platform_timer_start = (void *)gtdt +
>> >> >> > >> +                                             gtdt->platform_timer_offset;
>> >> >> > >> +       if (acpi_gtdt_desc.platform_timer_start <
>> >> >> > >> +           (void *)table + sizeof(struct acpi_table_gtdt)) {
>> >> >> > >> +               pr_err(FW_BUG "Platform Timer pointer error.\n");
>> >> >> > >
>> >> >> > > Why pr_err()?
>> >> >> >
>> >> >> > if (true), that means the GTDT table has bugs.
>> >> >> >
>> >> >>
>> >> >> And that's not a very useful piece of information unless you're debugging the
>> >> >> platform, is it?
>> >> >
>> >> > FWIW, I'm not a big fan of printing "your firmware is buggy" type of messages
>> >> > (especially at the "error" log level or higher) unless they can be clearly
>> >> > connected to a specific type of functional failure.
>> >> >
>> >> > So if you want to pring an error-level message, something like "I cannot do X
>> >> > because of the firmware bug Y" would be better IMO.
>> >>
>> >> So can I do this:
>> >> pr_err(FW_BUG "Can NOT init platform_timer pointer, because of the
>> >> GTDT table bug\n");
>> >>
>> >> or pr_debug(FW_BUG "Can NOT init platform_timer_start, because of
>> >> platform_timer_offset bug in GTDT\n");
>> >>
>> >> or just delete it?
>> >>
>> >> which one do you prefer?  I think maybe should provide some clue for
>> >> users to fix the problem  :-)
>> >
>> > And how exactly would they fix it then?
>> >
>> >>
>> >> any thought ?
>> >
>> > If you print variable or function names and the like, the message should be
>> > a debug one, because that's information that can only be understood by
>> > developers (some developers are users too, but they are a minority).
>> >
>> > If you want to report an error, say what is not working (or not available
>> > etc) and why (if you know the reason at the time the message is printed).
>>
>> Great thanks, I guess I got you point.
>>
>> maybe just a very simple message like:
>> pr_err(FW_BUG "Failed to init table: GTDT table is buggy.\n");
>
> To understand this message one needs to know what "table" means here
> and what "GTDT" is.  Also the prefix already will be something like
> "ACPI: GTDT:", so repeating part of it is not really useful IMO.
>
> Can you tell me please what's not going to work when that message is printed?
>
> Will the system boot at all then?  If so, the functionality will be limited
> somehow I suppose.  How is it going to be limited?

when that message is printed, all kind of platform timer(memory-mapped
timer and SBSA watchdog) can't work.
actually, I think system can boot without them.
I have updated this on my v8(just posted), let's discuss this on v8 :-)

>
>> I will also check other pr_* , if I can update them
>
> OK, great!
>
> Thanks,
> Rafael
>



-- 
Best regards,

Fu Wei
Software Engineer
Red Hat
