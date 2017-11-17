Return-Path: <linux-watchdog-owner@vger.kernel.org>
Received: from mail-qt0-f193.google.com ([209.85.216.193]:43502 "EHLO
        mail-qt0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1758433AbdKQOzf (ORCPT
        <rfc822;linux-watchdog@vger.kernel.org>);
        Fri, 17 Nov 2017 09:55:35 -0500
Received: by mail-qt0-f193.google.com with SMTP id n61so6600290qte.10
        for <linux-watchdog@vger.kernel.org>; Fri, 17 Nov 2017 06:55:35 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <20171117142203.GG17880@kroah.com>
References: <20171117142203.GG17880@kroah.com>
From: Philippe Ombredanne <pombredanne@nexb.com>
Date: Fri, 17 Nov 2017 15:54:53 +0100
Message-ID: <CAOFm3uEVMKOvyGzO2OxbLxGwYwbhUeTsEu98GopfY=MjMfoWSQ@mail.gmail.com>
Subject: Re: [PATCH] watchdog: pcwd_usb: remove unneeded DRIVER_LICENSE #define
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Wim Van Sebroeck <wim@iguana.be>,
        Guenter Roeck <linux@roeck-us.net>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-watchdog@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

On Fri, Nov 17, 2017 at 3:22 PM, Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
> There is no need to #define the license of the driver, just put it in
> the MODULE_LICENSE() line directly as a text string.
>
> This allows tools that check that the module license matches the source
> code license to work properly, as there is no need to unwind the
> unneeded dereference, especially when it is defined just a few lines
> above from where it is used.
>
> Cc: Wim Van Sebroeck <wim@iguana.be>
> Cc: Guenter Roeck <linux@roeck-us.net>
> Reported-by: Philippe Ombredanne <pombredanne@nexb.com>
> Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>


Reviewed-by: Philippe Ombredanne <pombredanne@nexb.com>
-- 
Cordially
Philippe Ombredanne
