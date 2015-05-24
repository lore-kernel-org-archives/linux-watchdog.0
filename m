Return-path: <fu.wei@linaro.org>
MIME-Version: 1.0
In-Reply-To: <20150522150554.GB2930@roeck-us.net>
References: <=fu.wei@linaro.org>
	<1432197156-16947-1-git-send-email-fu.wei@linaro.org>
	<1432197156-16947-6-git-send-email-fu.wei@linaro.org>
	<555ECD04.6000404@offcode.fi>
	<CADyBb7sZWgNnEoTfaYm6=YcbWgEYRMcaNAdX9Y7B6W9pg+gOmg@mail.gmail.com>
	<555EEFDB.2030907@offcode.fi>
	<CADyBb7uh-6=ihfrKHBVXDzAKAE-_GqLXTPJa5_7Gw2R71pyeUg@mail.gmail.com>
	<555F2DED.2010200@roeck-us.net>
	<CADyBb7swfV9eQKC2FxiaK=RFq9JR8fmq1BcTeWOp57i_TrXaBA@mail.gmail.com>
	<20150522150554.GB2930@roeck-us.net>
Date: Mon, 25 May 2015 00:17:31 +0800
Message-ID: <CADyBb7tS8vv4daa4Nx1ALMdNGkAkLaHXQVMrvKntCGKrM9FCKA@mail.gmail.com>
Subject: Re: [PATCH v2 5/7] Watchdog: introduce "pretimeout" into framework
From: Fu Wei <fu.wei@linaro.org>
To: Guenter Roeck <linux@roeck-us.net>
Cc: Timo Kokkonen <timo.kokkonen@offcode.fi>,
	Suravee Suthikulpanit <Suravee.Suthikulpanit@amd.com>,
	Linaro ACPI Mailman List <linaro-acpi@lists.linaro.org>, linux-watchdog@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-doc@vger.kernel.org, Wei Fu <tekkamanninja@gmail.com>,
	G Gregory <graeme.gregory@linaro.org>, Al Stone <al.stone@linaro.org>,
	Hanjun Guo <hanjun.guo@linaro.org>, Timur Tabi <timur@codeaurora.org>,
	Ashwin Chaugule <ashwin.chaugule@linaro.org>, Arnd Bergmann <arnd@arndb.de>, vgandhi@codeaurora.org,
	wim@iguana.be, Jon Masters <jcm@redhat.com>, Leo Duran <leo.duran@amd.com>,
	Jon Corbet <corbet@lwn.net>, Mark Rutland <mark.rutland@arm.com>
Content-Type: text/plain; charset=UTF-8
List-ID: <linux-watchdog@vger.kernel.org>

Hi Guenter,


On 22 May 2015 at 23:05, Guenter Roeck <linux@roeck-us.net> wrote:
> On Fri, May 22, 2015 at 10:38:32PM +0800, Fu Wei wrote:
>> Hi Guenter.
>>
>> Sorry for my poor English .
>> let me explain this :
>>
>> On 22 May 2015 at 21:23, Guenter Roeck <linux@roeck-us.net> wrote:
>> > On 05/22/2015 03:46 AM, Fu Wei wrote:
>> >>
>> >> Hi Timo,
>> >>
>> > [ ... ]
>> >
>> >> So I am still trying to improve pretimeout support :-)
>> >
>> >
>> > Is there anything still missing from it ?
>> >
>> >> If I can make pretimeout merged, may be you can try pretimeout to
>> >> implement early_timeout_sec function?
>> >
>> >
>> > Not sure how one would or even could do that.
>> >
>> > Do you mean "implement early_pretimeout_sec", by any chance ?
>>
>> I mean: using pretimeout to implement the function you want, instead
>> of early_pretimeout_sec
>>
> How would this work if the watchdog hardware doesn't support pretimeout ?
>
> Pretimeout and early timeout are two logically different functions, with
> different goals, so I don't entirely (if at all) understand why it would
> make sense to tie them together.
>
> Can you elaborate why you think this would be a good idea ?

sorry,  my apology.  forget about this, :-)
I think we should focus on SBSA watchdog patch here, but not a
early_timeout_sec.

>
> Thanks,
> Guenter
> --
> To unsubscribe from this list: send the line "unsubscribe devicetree" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html



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
