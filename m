Return-path: <rjwysocki@gmail.com>
MIME-Version: 1.0
Sender: rjwysocki@gmail.com
In-Reply-To: <20160713210857.GA9500@roeck-us.net>
References: <1468432402-4872-1-git-send-email-fu.wei@linaro.org>
 <1468432402-4872-5-git-send-email-fu.wei@linaro.org> <CAJZ5v0i-1NysCiDFX4ST_uBBeYF2YNzWztgDP=u9a4S1OdpWuw@mail.gmail.com>
 <20160713210857.GA9500@roeck-us.net>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Wed, 13 Jul 2016 23:43:39 +0200
Message-ID: <CAJZ5v0jnNqjpcY1CGkHxbJFwX1MuRi-U=jTCKWavMdEH4bKR3g@mail.gmail.com>
Subject: Re: [PATCH v7 4/9] acpi/arm64: Add GTDT table parse driver
To: Guenter Roeck <linux@roeck-us.net>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, Fu Wei <fu.wei@linaro.org>,
	"Rafael J. Wysocki" <rjw@rjwysocki.net>, Len Brown <lenb@kernel.org>,
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
	Leo Duran <leo.duran@amd.com>,
	"linux-watchdog@vger.kernel.org" <linux-watchdog@vger.kernel.org>, David Miller <davem@davemloft.net>,
	Andrew Morton <akpm@linux-foundation.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	kvalo@codeaurora.org, mchehab@kernel.org, Jiri Slaby <jslaby@suse.cz>,
	christoffer.dall@linaro.org, julien.grall@arm.com
Content-Type: text/plain; charset=UTF-8
List-ID: <linux-watchdog@vger.kernel.org>

On Wed, Jul 13, 2016 at 11:08 PM, Guenter Roeck <linux@roeck-us.net> wrote:
> On Wed, Jul 13, 2016 at 10:30:37PM +0200, Rafael J. Wysocki wrote:
>> On Wed, Jul 13, 2016 at 7:53 PM,  <fu.wei@linaro.org> wrote:
>> > From: Fu Wei <fu.wei@linaro.org>
>> >
>> > This patch adds support for parsing arch timer in GTDT,
>> > provides some kernel APIs to parse all the PPIs and
>> > always-on info in GTDT and export them.
>> >
>> > By this driver, we can simplify arm_arch_timer drivers, and
>> > separate the ACPI GTDT knowledge from it.
>> >
>> > Signed-off-by: Fu Wei <fu.wei@linaro.org>
>> > Signed-off-by: Hanjun Guo <hanjun.guo@linaro.org>
>> > ---
>> >  drivers/acpi/Kconfig           |   5 ++
>> >  drivers/acpi/Makefile          |   1 +
>> >  drivers/acpi/arm64/Kconfig     |  15 ++++
>> >  drivers/acpi/arm64/Makefile    |   1 +
>> >  drivers/acpi/arm64/acpi_gtdt.c | 170 +++++++++++++++++++++++++++++++++++++++++
>> >  include/linux/acpi.h           |   6 ++
>> >  6 files changed, 198 insertions(+)
>> >
>> > diff --git a/drivers/acpi/Kconfig b/drivers/acpi/Kconfig
>> > index b7e2e77..1cdc7d2 100644
>> > --- a/drivers/acpi/Kconfig
>> > +++ b/drivers/acpi/Kconfig
>> > @@ -521,4 +521,9 @@ config XPOWER_PMIC_OPREGION
>> >
>> >  endif
>> >
>> > +if ARM64
>> > +source "drivers/acpi/arm64/Kconfig"
>> > +
>> > +endif
>> > +
>> >  endif  # ACPI
>> > diff --git a/drivers/acpi/Makefile b/drivers/acpi/Makefile
>> > index 251ce85..1a94ff7 100644
>> > --- a/drivers/acpi/Makefile
>> > +++ b/drivers/acpi/Makefile
>> > @@ -99,5 +99,6 @@ obj-$(CONFIG_ACPI_EXTLOG)     += acpi_extlog.o
>> >  obj-$(CONFIG_PMIC_OPREGION)    += pmic/intel_pmic.o
>> >  obj-$(CONFIG_CRC_PMIC_OPREGION) += pmic/intel_pmic_crc.o
>> >  obj-$(CONFIG_XPOWER_PMIC_OPREGION) += pmic/intel_pmic_xpower.o
>> > +obj-$(CONFIG_ARM64)    += arm64/
>> >
>> >  video-objs                     += acpi_video.o video_detect.o
>> > diff --git a/drivers/acpi/arm64/Kconfig b/drivers/acpi/arm64/Kconfig
>> > new file mode 100644
>> > index 0000000..ff5c253
>> > --- /dev/null
>> > +++ b/drivers/acpi/arm64/Kconfig
>> > @@ -0,0 +1,15 @@
>> > +#
>> > +# ACPI Configuration for ARM64
>> > +#
>> > +
>> > +menu "The ARM64-specific ACPI Support"
>> > +
>> > +config ACPI_GTDT
>> > +       bool "ACPI GTDT table Support"
>>
>> This should depend on ARM64.
>>
>> Also I wonder if it needs to be user-selectable?  Wouldn't it be
>> better to enable it by default when building for ARM64 with ACPI?
>>
> It is currently selected in patch 9, in the watchdog driver's Kconfig
> entry.

Well, it still doesn't have to be user-selectable for that. :-)

> Not sure if I like that; maybe the watchdog driver should depend
> on it instead ?

If the watchdog is not the only user of it (and I don't think it is),
it would be better to arrange things this way.

Thanks,
Rafael
