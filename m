Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from mail-vk0-f52.google.com ([209.85.213.52]:33578 "EHLO
	mail-vk0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753348AbcEPQRu (ORCPT
	<rfc822;linux-watchdog@vger.kernel.org>);
	Mon, 16 May 2016 12:17:50 -0400
Received: by mail-vk0-f52.google.com with SMTP id z184so65380052vkg.0
        for <linux-watchdog@vger.kernel.org>; Mon, 16 May 2016 09:17:50 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20160514163516.GA20158@spo001.leaseweb.nl>
References: <1459816666-87185-1-git-send-email-groeck@chromium.org>
	<20160514163516.GA20158@spo001.leaseweb.nl>
Date: Mon, 16 May 2016 09:17:49 -0700
Message-ID: <CANEJEGviA5jqHBxxj=macC8Zc2-jFcJ-oQKoA-eys36nsqqEMQ@mail.gmail.com>
Subject: Re: [PATCH] watchdog: qcom: Report reboot reason
From: Grant Grundler <grundler@chromium.org>
To: Wim Van Sebroeck <wim@iguana.be>
Cc: Guenter Roeck <groeck@chromium.org>,
	Guenter Roeck <linux@roeck-us.net>,
	linux-watchdog@vger.kernel.org,
	LKML <linux-kernel@vger.kernel.org>,
	Grant Grundler <grundler@chromium.org>
Content-Type: text/plain; charset=UTF-8
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

[plain text this time...]

On Sat, May 14, 2016 at 9:35 AM, Wim Van Sebroeck <wim@iguana.be> wrote:
>
> Hi Guenter,
>
> > The Qualcom watchdog timer block reports if the system was reset by the
> > watchdog. Pass the information to user space.
> >
> > Cc: Grant Grundler <grundler@chromium.org>
> > Signed-off-by: Guenter Roeck <groeck@chromium.org>
> > ---
> >  drivers/watchdog/qcom-wdt.c | 7 ++++++-
> >  1 file changed, 6 insertions(+), 1 deletion(-)
>
> This patch has been added into linux-watchdog-next.

Awesome - thanks Wim!

cheers,
grant

>
> Kind regards,
> Wim.
>
