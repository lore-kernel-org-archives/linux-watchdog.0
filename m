Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from mail1.bemta5.messagelabs.com ([195.245.231.139]:19087 "EHLO
        mail1.bemta5.messagelabs.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1751002AbdAQOUj (ORCPT
        <rfc822;linux-watchdog@vger.kernel.org>);
        Tue, 17 Jan 2017 09:20:39 -0500
From: Adam Thomson <Adam.Thomson.Opensource@diasemi.com>
To: Guenter Roeck <linux@roeck-us.net>,
        Wim Van Sebroeck <wim@iguana.be>
CC: "linux-watchdog@vger.kernel.org" <linux-watchdog@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "Support Opensource" <Support.Opensource@diasemi.com>
Subject: RE: [PATCH 11/62] watchdog: da9052_wdt: Convert to use device
 managed functions
Date: Tue, 17 Jan 2017 14:12:03 +0000
Message-ID: <2E89032DDAA8B9408CB92943514A03370142A77D3E@SW-EX-MBX01.diasemi.com>
References: <1484091325-9199-1-git-send-email-linux@roeck-us.net>
 <1484091325-9199-12-git-send-email-linux@roeck-us.net>
In-Reply-To: <1484091325-9199-12-git-send-email-linux@roeck-us.net>
Content-Language: en-US
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

On 10 January 2017 23:34, Guenter Roeck wrote:

> Use device managed functions to simplify error handling, reduce
> source code size, improve readability, and reduce the likelyhood of bugs.
> 
> The conversion was done automatically with coccinelle using the
> following semantic patches. The semantic patches and the scripts used
> to generate this commit log are available at
> https://github.com/groeck/coccinelle-patches
> 
> - Replace 'goto l; ... l: return e;' with 'return e;'
> - Replace 'val = e; return val;' with 'return e;'
> - Drop assignments to otherwise unused variables
> - Replace 'if (e) { return expr; }' with 'if (e) return expr;'
> - Drop remove function
> - Drop platform_set_drvdata()
> - Use devm_watchdog_register_driver() to register watchdog device
> 
> Cc: Support Opensource <support.opensource@diasemi.com>
> Signed-off-by: Guenter Roeck <linux@roeck-us.net>
> ---

Acked-by: Adam Thomson <Adam.Thomson.Opensource@diasemi.com>
