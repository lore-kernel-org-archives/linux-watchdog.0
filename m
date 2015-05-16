Return-path: <fu.wei@linaro.org>
Message-ID: <55571C10.7020105@linaro.org>
Date: Sat, 16 May 2015 18:29:36 +0800
From: Fu Wei <fu.wei@linaro.org>
Reply-To: Fu Wei <fu.wei@linaro.org>
MIME-Version: 1.0
To: Arnd Bergmann <arnd@arndb.de>
CC: Suravee.Suthikulpanit@amd.com, linaro-acpi@lists.linaro.org,
 linux-watchdog@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
 tekkamanninja@gmail.com, graeme.gregory@linaro.org, al.stone@linaro.org,
 hanjun.guo@linaro.org, timur@codeaurora.org, ashwin.chaugule@linaro.org,
 linux@roeck-us.net, vgandhi@codeaurora.org, wim@iguana.be,
 jcm@redhat.com, leo.duran@amd.com, corbet@lwn.net
Subject: Re: [PATCH 1/6] Documentation: add sbsa-gwdt.txt documentation
References: <=fu.wei@linaro.org> <1431688090-2145-1-git-send-email-fu.wei@linaro.org> <1431688090-2145-2-git-send-email-fu.wei@linaro.org> <8715806.mTJfA5WAcP@wuerfel>
In-Reply-To: <8715806.mTJfA5WAcP@wuerfel>
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
List-ID: <linux-watchdog@vger.kernel.org>

Hi Arnd,

Great thanks for reminding, I should do it earlier.
You will see it in next patchset.

On 05/15/2015 10:06 PM, Arnd Bergmann wrote:
> On Friday 15 May 2015 19:08:05 fu.wei@linaro.org wrote:
>> From: Fu Wei <fu.wei@linaro.org>
>>
>> The sbsa-gwdt.txt documentation in devicetree/bindings/watchdog is for
>> introducing SBSA(Server Base System Architecture) Generic Watchdog
>> device node info into FDT
>>
>> Signed-off-by: Fu Wei <fu.wei@linaro.org>
> 
> Looks good, just one minor comment:
> 
>> +Optional properties
>> +- timeout-sec : Watchdog pre-timeout and timeout values (in seconds).
>> +	The first is timeout values, then pre-timeout.
> 
> Please update Documentation/watchdog/watchdog-kernel-api.txt as well, to
> mention the second number in the timeout-sec property.
> 
> 	Arnd
> 
> --
> To unsubscribe from this list: send the line "unsubscribe devicetree" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 


-- 
Best regards,

Fu Wei
Software Engineer From Red Hat
LEG Team
Linaro.org | Open source software for ARM SoCs
Ph: +86 186 2020 4684 (mobile)
IRC: fuwei
Skype: tekkamanninja
Room 1512, Regus One Corporate Avenue,Level 15,
One Corporate Avenue,222 Hubin Road,Huangpu District,
Shanghai,China 200021 
