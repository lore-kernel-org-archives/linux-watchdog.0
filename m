Return-path: <fu.wei@linaro.org>
MIME-Version: 1.0
In-Reply-To: <20150914042104.GA4682@localhost.localdomain>
References: <=fu.wei@linaro.org>
	<1433217907-928-1-git-send-email-fu.wei@linaro.org>
	<1433217907-928-6-git-send-email-fu.wei@linaro.org>
	<556F4489.6030206@codeaurora.org>
	<20150603182503.GD6460@roeck-us.net>
	<556F4D29.1080001@codeaurora.org>
	<55F207FD.2030007@redhat.com>
	<20150914042104.GA4682@localhost.localdomain>
Date: Mon, 14 Sep 2015 23:27:55 +0800
Message-ID: <CADyBb7veKjm78ur44QBKNVgxuoMZUDyzmMbiyS6crsi1Bo57Bg@mail.gmail.com>
Subject: Re: [PATCH v4 5/7] Watchdog: introduce ARM SBSA watchdog driver
From: Fu Wei <fu.wei@linaro.org>
To: Pratyush Anand <panand@redhat.com>
Cc: Jon Masters <jcm@redhat.com>, Timur Tabi <timur@codeaurora.org>,
	Guenter Roeck <linux@roeck-us.net>, Suravee Suthikulpanit <Suravee.Suthikulpanit@amd.com>,
	Linaro ACPI Mailman List <linaro-acpi@lists.linaro.org>, linux-watchdog@vger.kernel.org,
	devicetree@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>,
	linux-doc@vger.kernel.org, Wei Fu <tekkamanninja@gmail.com>,
	G Gregory <graeme.gregory@linaro.org>, Al Stone <al.stone@linaro.org>,
	Hanjun Guo <hanjun.guo@linaro.org>, Ashwin Chaugule <ashwin.chaugule@linaro.org>,
	Arnd Bergmann <arnd@arndb.de>, Vipul Gandhi <vgandhi@codeaurora.org>, Wim Van Sebroeck <wim@iguana.be>,
	Leo Duran <leo.duran@amd.com>, Jon Corbet <corbet@lwn.net>, Mark Rutland <mark.rutland@arm.com>,
	Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will.deacon@arm.com>,
	Rafael Wysocki <rjw@rjwysocki.net>
Content-Type: text/plain; charset=UTF-8
List-ID: <linux-watchdog@vger.kernel.org>

Hi Pratyush,

Great thanks for your help on some update for watchdog framework.

For " Fix parent of watchdog_devices", I will update my patchset.
For the upstreaming patchset"Sysfs status read support", will make a
patch. But upstream it when your patchset is merged.

On 14 September 2015 at 12:21, Pratyush Anand <panand@redhat.com> wrote:
> On 10/09/2015:06:45:17 PM, Jon Masters wrote:
>> On 06/03/2015 02:53 PM, Timur Tabi wrote:
>> > On 06/03/2015 01:25 PM, Guenter Roeck wrote:
>> >> In general the idea here would be to use a crashdump kernel, which,
>> >> when loaded, would reset the watchdog before it fires. This kernel
>> >> would then write a core dump to a specified location.
>
> And this is what we do in fedora or RHEL. There had been some work ongoing in
> fedora [1][2] which will help to reset any active watchdog in kdump kernel(if
> the watchdog driver has been registered to watchdog_class). It will eventually
> help a watchdog on ARM64 platform as well.
>
> [1] https://lists.fedoraproject.org/pipermail/kexec/2015-September/002295.html
> [2] https://github.com/pratyushanand/kexec-tools/commits/watchdog_fmaster
>
> ~Pratyush



-- 
Best regards,

Fu Wei
Software Engineer
Red Hat Software (Beijing) Co.,Ltd.Shanghai Branch
Ph: +86 21 61221326(direct)
Ph: +86 186 2020 4684 (mobile)
Room 1512, Regus One Corporate Avenue,Level 15,
One Corporate Avenue,222 Hubin Road,Huangpu District,
Shanghai,China 200021
