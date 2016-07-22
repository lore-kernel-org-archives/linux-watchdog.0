Return-path: <timur@codeaurora.org>
Subject: Re: [PATCH v2] Documentation/watchdog: check return value for magic
 close
To: Arnd Bergmann <arnd@arndb.de>, Wim Van Sebroeck <wim@iguana.be>
Cc: Guenter Roeck <linux@roeck-us.net>, Jonathan Corbet <corbet@lwn.net>,
 linux-watchdog@vger.kernel.org, linux-doc@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20160719154136.3132886-1-arnd@arndb.de>
From: Timur Tabi <timur@codeaurora.org>
Message-ID: <57929062.1000500@codeaurora.org>
Date: Fri, 22 Jul 2016 16:30:10 -0500
MIME-Version: 1.0
In-Reply-To: <20160719154136.3132886-1-arnd@arndb.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
List-ID: <linux-watchdog@vger.kernel.org>

Arnd Bergmann wrote:
> A recent commit added a write to the watchdog test code for doing the "magic
> close", but that caused a compile-time warning:
>
> Documentation/watchdog/src/watchdog-test.c: In function ‘main’:
> Documentation/watchdog/src/watchdog-test.c:94:5: warning: ignoring return value of ‘write’, declared with attribute warn_unused_result [-Wunused-result]
>
> This changes the code to print a runtime warning if the write fails.
>
> Fixes: 5a2d3de19602 ("Documentation/watchdog: add support for magic close to watchdog-test")
> Signed-off-by: Arnd Bergmann<arnd@arndb.de>

Acked-by: Timur Tabi <timur@codeaurora.org>

Thanks for this patch.  I don't know why I didn't notice the warnings 
before.

-- 
Qualcomm Datacenter Technologies, Inc. as an affiliate of Qualcomm
Technologies, Inc.  Qualcomm Technologies, Inc. is a member of the
Code Aurora Forum, a Linux Foundation Collaborative Project.
