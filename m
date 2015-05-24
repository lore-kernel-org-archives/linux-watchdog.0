Return-path: <fu.wei@linaro.org>
MIME-Version: 1.0
In-Reply-To: <5561FC70.5080802@roeck-us.net>
References: <=fu.wei@linaro.org>
	<1432197156-16947-1-git-send-email-fu.wei@linaro.org>
	<1432197156-16947-7-git-send-email-fu.wei@linaro.org>
	<555DFCD4.3040701@codeaurora.org>
	<CADyBb7vpC6ihvkrRG-htCS8-_xRkjtny=9ZGQsCsmK7-ng5AxA@mail.gmail.com>
	<5560D7AC.50009@codeaurora.org>
	<5560DCB6.3090008@roeck-us.net>
	<CADyBb7t7+aT=pF0we5umAGXJAJ0njU0zULFAZ-OHVpE0m=ueyg@mail.gmail.com>
	<5561E7EA.5090702@codeaurora.org>
	<CADyBb7tYL7ATRKNAoRYTXo53LKdCiFZ2YDib4g0nZ8=YxTgO+A@mail.gmail.com>
	<5561F8A8.4080607@codeaurora.org>
	<5561FC70.5080802@roeck-us.net>
Date: Mon, 25 May 2015 00:33:10 +0800
Message-ID: <CADyBb7uy=cPqgx5y+wFUhP7CpVQbvyycPTHnNM=G6BO43PhhYQ@mail.gmail.com>
Subject: Re: [PATCH v2 6/7] Watchdog: introduce ARM SBSA watchdog driver
From: Fu Wei <fu.wei@linaro.org>
To: Guenter Roeck <linux@roeck-us.net>
Cc: Timur Tabi <timur@codeaurora.org>,
	Suravee Suthikulpanit <Suravee.Suthikulpanit@amd.com>,
	Linaro ACPI Mailman List <linaro-acpi@lists.linaro.org>, linux-watchdog@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-doc@vger.kernel.org, Wei Fu <tekkamanninja@gmail.com>,
	G Gregory <graeme.gregory@linaro.org>, Al Stone <al.stone@linaro.org>,
	Hanjun Guo <hanjun.guo@linaro.org>, Ashwin Chaugule <ashwin.chaugule@linaro.org>,
	Arnd Bergmann <arnd@arndb.de>, vgandhi@codeaurora.org, wim@iguana.be,
	Jon Masters <jcm@redhat.com>, Leo Duran <leo.duran@amd.com>, Jon Corbet <corbet@lwn.net>,
	Mark Rutland <mark.rutland@arm.com>
Content-Type: text/plain; charset=UTF-8
List-ID: <linux-watchdog@vger.kernel.org>

Hi Guenter

On 25 May 2015 at 00:29, Guenter Roeck <linux@roeck-us.net> wrote:
> On 05/24/2015 09:13 AM, Timur Tabi wrote:
>>
>> Fu Wei wrote:
>>>
>>> in the first timeout, just panic()  maybe not enough,  in [RFC]
>>> version of my patchset, I offer some option as "preaction" to use, but
>>> for simplifying the first version of driver, I have deleted them.
>>> but at least, panic() is far more useful than a simple reset.  at
>>> least, it can provide the context of the crashed system  to admin.
>>
>>
>> My point is that there is very little difference between
>>
>> 1) calling panic() on pre-timeout
>> 2) calling panic() on timeout
>>
>
> The assumption would be that the second timeout doesn't cause a panic
> but a system reset.
>
>> In both cases, the system will panic.  The watchdog API says that the
>> system should reset when a timeout occurs, so you cannot call panic() before
>> the timeout expires.
>>
>>  > If you want to warn user space, that will make driver more
>>  > complicated, I don't think that is a good choose for a first version.
>>  > but we can find a way to improve this later
>>
>> In my opinion, this "first version" is not useful.  I would like to see a
>> pre-timeout feature that does not panic or reset when a pre-timeout occurs.
>>
>
> The current watchdog API suggests that the pretimeout "allows Linux
> to record useful information (like panic information and kernel
> coredumps) before it resets". The call to panic() would be the
> means to make this happen.

Yes, that is what I mean. Great thanks for your explanation. :-)

>
> Are you suggesting to change this definition ? What should it do
> instead in your opinion ?
>
> Thanks,
> Guenter
>



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
