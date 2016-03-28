Return-path: <fu.wei@linaro.org>
MIME-Version: 1.0
In-Reply-To: <20160328141136.GA13855@dhcppc0.redhat.com>
References: <1456735610-22012-1-git-send-email-fu.wei@linaro.org>
	<1456735610-22012-4-git-send-email-fu.wei@linaro.org>
	<CADyBb7shY-A-DTKEvNQS71SUtNmE6tkURfWDEb-_9eB-4htGWA@mail.gmail.com>
	<56F935AC.3020009@roeck-us.net>
	<20160328141136.GA13855@dhcppc0.redhat.com>
Date: Tue, 29 Mar 2016 01:16:58 +0800
Message-ID: <CADyBb7v68k9kPxLT403nD=b3EVWb+_571HPGpfa9q5a21+VfDA@mail.gmail.com>
Subject: Re: [PATCH v14 3/4] ARM64: add SBSA Generic Watchdog device node in amd-seattle-soc.dtsi
From: Fu Wei <fu.wei@linaro.org>
To: Pratyush Anand <panand@redhat.com>
Cc: Guenter Roeck <linux@roeck-us.net>, Arnd Bergmann <arnd@arndb.de>, Rob Herring <robh+dt@kernel.org>,
	=?UTF-8?Q?Pawe=C5=82_Moll?= <pawel.moll@arm.com>,
	Mark Rutland <mark.rutland@arm.com>, Ian Campbell <ijc+devicetree@hellion.org.uk>,
	Kumar Gala <galak@codeaurora.org>, Wim Van Sebroeck <wim@iguana.be>, Jon Corbet <corbet@lwn.net>,
	Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will.deacon@arm.com>,
	Suravee Suthikulpanit <Suravee.Suthikulpanit@amd.com>, LKML <linux-kernel@vger.kernel.org>,
	linux-watchdog@vger.kernel.org, linux-doc@vger.kernel.org,
	devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	Linaro ACPI Mailman List <linaro-acpi@lists.linaro.org>, Richard Ruigrok <rruigrok@codeaurora.org>,
	"Abdulhamid, Harb" <harba@codeaurora.org>, Christopher Covington <cov@codeaurora.org>,
	Timur Tabi <timur@codeaurora.org>, Dave Young <dyoung@redhat.com>,
	G Gregory <graeme.gregory@linaro.org>, Al Stone <al.stone@linaro.org>,
	Hanjun Guo <hanjun.guo@linaro.org>, Jon Masters <jcm@redhat.com>, Leo Duran <leo.duran@amd.com>,
	Sudeep Holla <sudeep.holla@arm.com>
Content-Type: text/plain; charset=UTF-8
List-ID: <linux-watchdog@vger.kernel.org>

Hi Pratyush, Guenter,

On 28 March 2016 at 22:11, Pratyush Anand <panand@redhat.com> wrote:
> On 28/03/2016:06:46:20 AM, Guenter Roeck wrote:
>> On 03/28/2016 06:12 AM, Fu Wei wrote:
>> >Hi Wim, Guenter:
>> >
>> >Great thanks for reviewing and applying this patchset :-)
>> >Now I can see almost all the patches of this patchset have been merged
>> >into the master branch of mainline kernel.
>> >But only this one is still out of any branch or repo. It seems that
>> >it's applied on linux-watchdog for a while, then disappeared.
>> >
>> >
>> >So any thing I can do for this patch? Do I need to resubmit it?
>> >Maybe I miss it in some repo? Could you help me ?
>> >Great thanks ! :-)
>> >
>>
>> If I recall correctly, it was supposed to go in through some other tree (arm-soc ?)
>
> Yes, it should have gone through arm-soc tree. But, it seems it got missed.  The
> other dt patch for foundation-v8 is there in v4.6 pull request
> [https://lkml.org/lkml/2016/3/20/244].

Yes, I thought it should be in arm-soc, but I have checked several
branches in arm-soc repo, I can't find this patch.
So can someone help to apply it.  I have applied it on the master
branch of latest mainline kernel locally, I don't see any conflict.

Great thanks :-)

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
