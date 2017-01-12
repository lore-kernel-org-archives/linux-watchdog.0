Return-path: <vz@mleia.com>
Subject: Re: [PATCH 44/62] watchdog: pnx4008_wdt: Convert to use device
 managed functions
To: Guenter Roeck <linux@roeck-us.net>, Wim Van Sebroeck <wim@iguana.be>
References: <1484091325-9199-1-git-send-email-linux@roeck-us.net>
 <1484095516-12720-1-git-send-email-linux@roeck-us.net>
 <1484095516-12720-14-git-send-email-linux@roeck-us.net>
Cc: linux-watchdog@vger.kernel.org, linux-kernel@vger.kernel.org,
 Sylvain Lemieux <slemieux.tyco@gmail.com>,
 linux-arm-kernel@lists.infradead.org
From: Vladimir Zapolskiy <vz@mleia.com>
Message-ID: <94652a06-cd97-5ad2-a40b-fca3a4a33ccb@mleia.com>
Date: Thu, 12 Jan 2017 02:13:45 +0200
MIME-Version: 1.0
In-Reply-To: <1484095516-12720-14-git-send-email-linux@roeck-us.net>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
List-ID: <linux-watchdog@vger.kernel.org>

Hi Guenter,

On 01/11/2017 02:44 AM, Guenter Roeck wrote:
> Use device managed functions to simplify error handling, reduce
> source code size, improve readability, and reduce the likelyhood of bugs.
> 
> The conversion was done automatically with coccinelle using the
> following semantic patches. The semantic patches and the scripts used
> to generate this commit log are available at
> https://github.com/groeck/coccinelle-patches
> 
> - Use devm_add_action_or_reset() for calls to clk_disable_unprepare
> - Replace 'goto l; ... l: return e;' with 'return e;'
> - Drop remove function
> - Use devm_watchdog_register_driver() to register watchdog device
> 
> Cc: Vladimir Zapolskiy <vz@mleia.com>

Acked-by: Vladimir Zapolskiy <vz@mleia.com>

Thank you for the cleanup.

> Cc: Sylvain Lemieux <slemieux.tyco@gmail.com>
> Signed-off-by: Guenter Roeck <linux@roeck-us.net>

--
With best wishes,
Vladimir
