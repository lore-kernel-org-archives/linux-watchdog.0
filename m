Return-path: <wimvs@spo001.leaseweb.nl>
Date: Sat, 14 May 2016 18:35:16 +0200
From: Wim Van Sebroeck <wim@iguana.be>
To: Guenter Roeck <groeck@chromium.org>
Cc: Guenter Roeck <linux@roeck-us.net>, linux-watchdog@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Grant Grundler <grundler@chromium.org>
Subject: Re: [PATCH] watchdog: qcom: Report reboot reason
Message-ID: <20160514163516.GA20158@spo001.leaseweb.nl>
References: <1459816666-87185-1-git-send-email-groeck@chromium.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1459816666-87185-1-git-send-email-groeck@chromium.org>
Sender: <wimvs@spo001.leaseweb.nl>
List-ID: <linux-watchdog@vger.kernel.org>

Hi Guenter,

> The Qualcom watchdog timer block reports if the system was reset by the
> watchdog. Pass the information to user space.
> 
> Cc: Grant Grundler <grundler@chromium.org>
> Signed-off-by: Guenter Roeck <groeck@chromium.org>
> ---
>  drivers/watchdog/qcom-wdt.c | 7 ++++++-
>  1 file changed, 6 insertions(+), 1 deletion(-)

This patch has been added into linux-watchdog-next.

Kind regards,
Wim.
