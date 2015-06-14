Return-path: <fu.wei@linaro.org>
MIME-Version: 1.0
In-Reply-To: <557A58A5.4010208@codeaurora.org>
References: <=fu.wei@linaro.org>
	<1433958452-23721-1-git-send-email-fu.wei@linaro.org>
	<1433958452-23721-5-git-send-email-fu.wei@linaro.org>
	<557A58A5.4010208@codeaurora.org>
Date: Sun, 14 Jun 2015 18:15:57 +0800
Message-ID: <CADyBb7vRG+h-m_2YoMfu76Q_CqOVC7BafGzqaLmCkNF9QXpXHg@mail.gmail.com>
Subject: Re: [PATCH non-pretimeout 4/7] Watchdog: introduce ARM SBSA watchdog driver
From: Fu Wei <fu.wei@linaro.org>
To: Timur Tabi <timur@codeaurora.org>
Cc: Suravee Suthikulpanit <Suravee.Suthikulpanit@amd.com>,
	Linaro ACPI Mailman List <linaro-acpi@lists.linaro.org>, linux-watchdog@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-doc@vger.kernel.org, Wei Fu <tekkamanninja@gmail.com>,
	G Gregory <graeme.gregory@linaro.org>, Al Stone <al.stone@linaro.org>,
	Hanjun Guo <hanjun.guo@linaro.org>, Ashwin Chaugule <ashwin.chaugule@linaro.org>,
	Arnd Bergmann <arnd@arndb.de>, Guenter Roeck <linux@roeck-us.net>,
	Vipul Gandhi <vgandhi@codeaurora.org>, Wim Van Sebroeck <wim@iguana.be>, Jon Masters <jcm@redhat.com>,
	Leo Duran <leo.duran@amd.com>, Jon Corbet <corbet@lwn.net>, Mark Rutland <mark.rutland@arm.com>,
	Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will.deacon@arm.com>, rjw@rjwysocki.net
Content-Type: text/plain; charset=UTF-8
List-ID: <linux-watchdog@vger.kernel.org>

Hi Timur

On 12 June 2015 at 11:57, Timur Tabi <timur@codeaurora.org> wrote:
> fu.wei@linaro.org wrote:
>>
>> +       if (timeout <= gwdt->max_wor_timeout)
>> +               writel_relaxed(timeout * gwdt->clk,
>> +                              gwdt->control_base + SBSA_GWDT_WOR);
>> +       else
>> +               writel_relaxed(gwdt->max_wor_timeout * gwdt->clk,
>> +                              gwdt->control_base + SBSA_GWDT_WOR);
>
>
> You pre-calculate the maximum timeout possible already, so why do you need
> the if-statement?

Have took Guenter's suggestion on this.

>
> Frankly, your non-pretimeout driver is almost identical to mine, which was
> posted weeks ago.  At this point, you're really just copying my driver but
> putting your name on it.

Everyone can see how this driver become to this one gradually. For
non-pretimeout, if there is not pretimeout variable, I can only use
timeout to config both of them.
This is  definitely not the copy of yours(check yours again, you never
programme WCV, and from the comment from you , you didn't believe
driver can do that. you use panic because of my patch),  and I posted
my patchset(with pretimeout) to linaro-acpi list before you posted
yours to linux mailing list.  And I always focus on mine.

Let people judge from all these patchset, I don't want to argue with
you on this any more.


>
>
> --
> Sent by an employee of the Qualcomm Innovation Center, Inc.
> The Qualcomm Innovation Center, Inc. is a member of the
> Code Aurora Forum, hosted by The Linux Foundation.



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
