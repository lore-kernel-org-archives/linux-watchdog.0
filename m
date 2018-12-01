Return-Path: <linux-watchdog-owner@vger.kernel.org>
Received: from mail-it1-f195.google.com ([209.85.166.195]:36986 "EHLO
        mail-it1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726812AbeLBCKH (ORCPT
        <rfc822;linux-watchdog@vger.kernel.org>);
        Sat, 1 Dec 2018 21:10:07 -0500
MIME-Version: 1.0
References: <20181201101417.6368-1-tiny.windzz@gmail.com> <2b188937-e297-acb4-8c40-bb93ff5bbb76@roeck-us.net>
In-Reply-To: <2b188937-e297-acb4-8c40-bb93ff5bbb76@roeck-us.net>
From: Frank Lee <tiny.windzz@gmail.com>
Date: Sat, 1 Dec 2018 22:57:03 +0800
Message-ID: <CAEExFWu01nUBqb1N3R7rDXf96sLBYEfxOo06Q-ZAqMqYTmNKjQ@mail.gmail.com>
Subject: Re: [PATCH] watchdog: convert to DEFINE_SHOW_ATTRIBUTE
To: Guenter Roeck <linux@roeck-us.net>
Cc: wim@linux-watchdog.org, Florian Fainelli <f.fainelli@gmail.com>,
        rjui@broadcom.com, sbranden@broadcom.com,
        bcm-kernel-feedback-list@broadcom.com,
        linux-watchdog@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

On Sat, Dec 1, 2018 at 10:25 PM Guenter Roeck <linux@roeck-us.net> wrote:
>
> On 12/1/18 2:14 AM, Yangtao Li wrote:
> > Use DEFINE_SHOW_ATTRIBUTE macro to simplify the code.
> >
> > Signed-off-by: Yangtao Li <tiny.windzz@gmail.com>
>
> One patch per file, please.
>
> Guenter
Already split into small files.

MBR,
Yangtao
