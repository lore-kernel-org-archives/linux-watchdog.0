Return-Path: <wimvs@spo001.leaseweb.com>
Date: Tue, 29 Oct 2013 07:34:04 +0100
From: Wim Van Sebroeck <wim@iguana.be>
To: Guenter Roeck <linux@roeck-us.net>
Cc: linux-watchdog@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4] watchdog: w83627hf: Convert to watchdog infrastructure
Message-ID: <20131029063404.GA5261@spo001.leaseweb.com>
References: <1376773126-2717-1-git-send-email-linux@roeck-us.net> <1376773126-2717-2-git-send-email-linux@roeck-us.net> <20131028215755.GA13226@spo001.leaseweb.com> <20131029024357.GA27070@roeck-us.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20131029024357.GA27070@roeck-us.net>
Sender: <wimvs@spo001.leaseweb.com>
List-ID: <linux-watchdog@vger.kernel.org>

Hi Guenter,

> 
> Signed-off-by: Guenter Roeck <linux@roeck-us.net>
> ---
> v4: Restore 'nowayout' module parameter
> 
> The changes cause a trivial conflict with 'watchdog: w83627hf: Auto-detect
> IO address and supported chips'. Please let me know if I should re-send
> the entire series.

Let me review the other patches still before we do any re-sending.


Kind regards,
Wim.
