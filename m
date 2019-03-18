Return-Path: <SRS0=lwmN=RV=vger.kernel.org=linux-watchdog-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5DC09C43381
	for <linux-watchdog@archiver.kernel.org>; Mon, 18 Mar 2019 23:54:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 36D812173C
	for <linux-watchdog@archiver.kernel.org>; Mon, 18 Mar 2019 23:54:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726661AbfCRXyS (ORCPT
        <rfc822;linux-watchdog@archiver.kernel.org>);
        Mon, 18 Mar 2019 19:54:18 -0400
Received: from mail-lj1-f194.google.com ([209.85.208.194]:39685 "EHLO
        mail-lj1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726487AbfCRXyR (ORCPT
        <rfc822;linux-watchdog@vger.kernel.org>);
        Mon, 18 Mar 2019 19:54:17 -0400
Received: by mail-lj1-f194.google.com with SMTP id l7so5879761ljg.6
        for <linux-watchdog@vger.kernel.org>; Mon, 18 Mar 2019 16:54:16 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=7AlIxzRNj6Hklk9FgPfeiYnwlPn7E1BgNwif+MlRMz8=;
        b=F6ExJ3eQjXru0obxs5N0GX/exKNr9a+vGoXq8gfMlp6BQjzceYQBL/RmKsmH6nysQa
         QRqkyVO3fQ5mxZltUU5jqJqRHwFszz+lBWg2v4KF59MXvBwZs6Y4VtMP0e5H6zWm+6+3
         o1ALFAE8N7ZD2W2de5leF4tRefBDO5F2459KEUsipG4fkIViwFOWIavKEQXBPPBfKTPO
         Ei/EaUYQNEslv4IVkzPS4mTRTHf6ROjbauw4i3a0VarFz6j40Z15j8GI38JSEtsw42+I
         jGSyAvGjiGwmKCrp26848ArHMaMU/9yh7lkLXD2emjspNJZ7hZfc/MoqG6M2mhn9g+/h
         5aVA==
X-Gm-Message-State: APjAAAXg4PWm0Xtpna8piUYV01HwEb7QqvGgka/9JfK08qX7VdA4NRi5
        5vbx23Qvnnx8LhJIKfYHx6KroWILYdCFKq2iVetvbayrJfrmew==
X-Google-Smtp-Source: APXvYqwfNLwd1+6HxGjwI7X8IpeKm+nX20OhLW0ueB2PpYio0VUVkndO6KI8fw6w/tq8Ij+m8XzW+hxbjA3rFB9ldxg=
X-Received: by 2002:a2e:8555:: with SMTP id u21mr1115944ljj.130.1552953256184;
 Mon, 18 Mar 2019 16:54:16 -0700 (PDT)
MIME-Version: 1.0
References: <20190318011915.32442-1-mcroce@redhat.com> <5998d284-c714-0f46-ea3b-53cc8bf32a9b@roeck-us.net>
In-Reply-To: <5998d284-c714-0f46-ea3b-53cc8bf32a9b@roeck-us.net>
From:   Matteo Croce <mcroce@redhat.com>
Date:   Tue, 19 Mar 2019 00:53:40 +0100
Message-ID: <CAGnkfhzN_iutkyo5QAC8xTavpA=W=vG6VZW+b5nD1m+3PtiLbQ@mail.gmail.com>
Subject: Re: [PATCH] watchdog: i6300esb: stop printing kernel addresses
To:     Guenter Roeck <linux@roeck-us.net>
Cc:     linux-watchdog@vger.kernel.org,
        Wim Van Sebroeck <wim@linux-watchdog.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-watchdog-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-watchdog.vger.kernel.org>
X-Mailing-List: linux-watchdog@vger.kernel.org

On Mon, Mar 18, 2019 at 3:53 AM Guenter Roeck <linux@roeck-us.net> wrote:
>
> On 3/17/19 6:19 PM, Matteo Croce wrote:
> > Since commit ad67b74d2469d9b8 ("printk: hash addresses printed with %p"),
> > i6300esb prints "____ptrval____" instead of actual addresses:
> >
> >      i6300ESB timer 0000:00:03.0: initialized (0x(____ptrval____)). heartbeat=30 sec (nowayout=1)
> >
> > Instead of changing the print to "%px", and leaking kernel addresses,
> > just remove the print completely, cfr. e.g. commit 071929dbdd865f77
> > ("arm64: Stop printing the virtual memory layout").
> >
> > Signed-off-by: Matteo Croce <mcroce@redhat.com>
>
> Reviewed-by: Guenter Roeck <linux@roeck-us.net>
>
> > ---
> >   drivers/watchdog/i6300esb.c | 4 ++--
> >   1 file changed, 2 insertions(+), 2 deletions(-)
> >
> > diff --git a/drivers/watchdog/i6300esb.c b/drivers/watchdog/i6300esb.c
> > index 950c71a8bb22..e312a2aeecad 100644
> > --- a/drivers/watchdog/i6300esb.c
> > +++ b/drivers/watchdog/i6300esb.c
> > @@ -328,8 +328,8 @@ static int esb_probe(struct pci_dev *pdev,
> >               goto err_unmap;
> >       }
> >       dev_info(&pdev->dev,
> > -             "initialized (0x%p). heartbeat=%d sec (nowayout=%d)\n",
> > -             edev->base, edev->wdd.timeout, nowayout);
> > +             "initialized. heartbeat=%d sec (nowayout=%d)\n",
> > +             edev->wdd.timeout, nowayout);
> >       return 0;
> >
> >   err_unmap:
> >
>

Nit: can someone add the fixes tag before merge?

Fixes: ad67b74d2469d9b8 ("printk: hash addresses printed with %p")

Thanks,
-- 
Matteo Croce
per aspera ad upstream
