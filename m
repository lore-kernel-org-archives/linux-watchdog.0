Return-path: <timur@codeaurora.org>
Message-ID: <555F5728.5060209@codeaurora.org>
Date: Fri, 22 May 2015 11:19:52 -0500
From: Timur Tabi <timur@codeaurora.org>
MIME-Version: 1.0
To: Arnd Bergmann <arnd@arndb.de>, linaro-acpi@lists.linaro.org
CC: Hanjun Guo <hanjun.guo@linaro.org>,
 Guenter Roeck <linux@roeck-us.net>,
 corbet@lwn.net, devicetree@vger.kernel.org,
 linux-watchdog@vger.kernel.org, jcm@redhat.com,
 linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, wim@iguana.be,
 tekkamanninja@gmail.com, vgandhi@codeaurora.org
Subject: Re: [Linaro-acpi] [PATCH v2 6/7] Watchdog: introduce ARM SBSA watchdog
 driver
References: <=fu.wei@linaro.org> <20150522150145.GA2930@roeck-us.net> <555F48BD.4010605@linaro.org> <10437443.BChumWu5Uk@wuerfel>
In-Reply-To: <10437443.BChumWu5Uk@wuerfel>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
List-ID: <linux-watchdog@vger.kernel.org>

On 05/22/2015 10:24 AM, Arnd Bergmann wrote:
> That will break the ACPI case, but ACPI could use platform_data to
> pass the clock rate into the driver, to make it independent of
> low-level APIs.

The clock rate isn't the only problem.  You still need to current clock 
timestamp, and that's ARM-specific.

-- 
Qualcomm Innovation Center, Inc.
The Qualcomm Innovation Center, Inc. is a member of the
Code Aurora Forum, a Linux Foundation Collaborative Project.
