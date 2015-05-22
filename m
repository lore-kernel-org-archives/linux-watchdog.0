Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from oul135-36.netplaza.fi ([80.75.100.36]:58708 "EHLO
	lime.offcode.fi" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1756048AbbEVGag (ORCPT
	<rfc822;linux-watchdog@vger.kernel.org>);
	Fri, 22 May 2015 02:30:36 -0400
Message-ID: <555ECD04.6000404@offcode.fi>
Date: Fri, 22 May 2015 09:30:28 +0300
From: Timo Kokkonen <timo.kokkonen@offcode.fi>
MIME-Version: 1.0
To: fu.wei@linaro.org, Suravee.Suthikulpanit@amd.com,
	linaro-acpi@lists.linaro.org, linux-watchdog@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-doc@vger.kernel.org
CC: tekkamanninja@gmail.com, graeme.gregory@linaro.org,
	al.stone@linaro.org, hanjun.guo@linaro.org, timur@codeaurora.org,
	ashwin.chaugule@linaro.org, arnd@arndb.de, linux@roeck-us.net,
	vgandhi@codeaurora.org, wim@iguana.be, jcm@redhat.com,
	leo.duran@amd.com, corbet@lwn.net, mark.rutland@arm.com
Subject: Re: [PATCH v2 5/7] Watchdog: introduce "pretimeout" into framework
References: <=fu.wei@linaro.org> <1432197156-16947-1-git-send-email-fu.wei@linaro.org> <1432197156-16947-6-git-send-email-fu.wei@linaro.org>
In-Reply-To: <1432197156-16947-6-git-send-email-fu.wei@linaro.org>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

On 21.05.2015 11:32, fu.wei@linaro.org wrote:
> From: Fu Wei <fu.wei@linaro.org>
>
> Also update Documentation/watchdog/watchdog-kernel-api.txt to
> introduce:
> (1)the new elements in the watchdog_device and watchdog_ops struct;
> (2)the new API "watchdog_init_timeouts".
>
> Reasons:
> (1)kernel already has two watchdog drivers are using "pretimeout":
> 	drivers/char/ipmi/ipmi_watchdog.c
> 	drivers/watchdog/kempld_wdt.c(but the definition is different)
> (2)some other dirvers are going to use this: ARM SBSA Generic Watchdog
>

Hi,

As I was proposing some other API changes with my early-timeout-sec 
work, I can see my work is going to collide with your API change 
proposal a bit. So maybe I should ask your opinion as well..

Could this pretimeout feature be something that other drivers could 
benefit too? I can see that it does not do anything else except call 
panic() before letting the watchdog expire. This is something that could 
be emulated easily by the watchdog core for drivers that don't know 
anything about pretimeouts at all.

The way I was planning the API change there would need to be a small 
change with each watchdog driver in order to let the watchdog core take 
over generic behaviour on behalf of the driver. My goal was to make the 
change so that each driver that gets converted to the new API extensions 
gets a support for early-timeout-sec for free, without needing to enable 
support for it any way. If the API was designed properly, also 
pretimeouts could be handled easily and maybe even so that other drivers 
could have that feature even though their hardware does not explicitly 
give any support for it.

Any thoughts?

Thanks,
-Timo
