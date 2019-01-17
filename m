Return-Path: <SRS0=Jq5p=PZ=vger.kernel.org=linux-watchdog-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.6 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 29A4BC43387
	for <linux-watchdog@archiver.kernel.org>; Thu, 17 Jan 2019 19:09:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ECFBB20657
	for <linux-watchdog@archiver.kernel.org>; Thu, 17 Jan 2019 19:09:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="UK4FSuyw"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728384AbfAQTJp (ORCPT
        <rfc822;linux-watchdog@archiver.kernel.org>);
        Thu, 17 Jan 2019 14:09:45 -0500
Received: from mail-yb1-f194.google.com ([209.85.219.194]:43149 "EHLO
        mail-yb1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728291AbfAQTJp (ORCPT
        <rfc822;linux-watchdog@vger.kernel.org>);
        Thu, 17 Jan 2019 14:09:45 -0500
Received: by mail-yb1-f194.google.com with SMTP id t16so3405778ybk.10
        for <linux-watchdog@vger.kernel.org>; Thu, 17 Jan 2019 11:09:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=qe7NUhaOauVMHMbVmvcb9y61t5wbJ0dPWB9PLPVTivk=;
        b=UK4FSuywOA+U0Swg9Voygjxj28BHGHk/5iFcLo3SkApIegWZaXrpAT+73yUEbAQxY/
         fon1c6ftGSi9sS0xVvgLRwMoD6rEkpuMTE+RIMQ/Nr8ouBIodb1VSiV8PJzvDKmZbCiP
         5dffp0I4TZ2BOM50VIabdYfcI5LJR8HHRShnTkk0e8KRX6L41BghlD/s4NFH13yCuo7z
         RGaM5V2w0ie7f07OykvIgt2MA7QJcfGRTaMZ3PQWrIEfyNpBEmHIok+dbcSMgYRzPnoZ
         4JPTFUM+bFpAZEp9ENaxDD+uJBsEcCqtqzU1R1Kt+2VfxZS7WFUHtSBt2mzdwodaIY1z
         jCng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=qe7NUhaOauVMHMbVmvcb9y61t5wbJ0dPWB9PLPVTivk=;
        b=oBsVDz7tlOo7yvY4ghlwRuU4Xgie3BVci9x2V47mM9mCDMhwcF4NoRAhUy7HhkGNHn
         x8nLZCRu9l/TDK5IPHOAouzfFEmFOxgVVpr+a2YJ/A9rpd7WtRIN/8hpCErxkZfGgp2V
         R1TMtdY13Xn1dfagZ+vI8ZuOjSC87Js99oHCBXu8kX6LAMTGi4EhMOiyQ6SGy3DdNRz8
         DESPGcvqKndRNZSatHihZF/ROpHwm8Dr4GA/A/Ke/jo8P9jQkZqXy2YFpinNWMS37XKv
         ZA2NaVgcxJOFaobGJ3AAJSH2Y9pmW7icct+8J7pAEVlfGxtqSe/njHbnU+j9IKyrnv4v
         wmOQ==
X-Gm-Message-State: AJcUukcydGx1yA9A74bcNrwEYnrhSHTRAesbN+JuAkve8pJEi/GYoR4t
        8h4iJGEi2/2op3NhXPNvnKInQ2lJoQS4cqDY5eoBWPiD/1XrjQ==
X-Google-Smtp-Source: ALg8bN4W9AvA2U2fwcNHBAUpaLURSX1Sx0s7/VHk6pgUZPY83dNqFkQgrHIClaTANPfSi43TmCMJFuJAGi8wbrm/Qro=
X-Received: by 2002:a25:8685:: with SMTP id z5mr3246200ybk.247.1547752183617;
 Thu, 17 Jan 2019 11:09:43 -0800 (PST)
MIME-Version: 1.0
References: <20190117151942.6092-1-saiprakash.ranjan@codeaurora.org> <154775022743.169631.1716489383315213219@swboyd.mtv.corp.google.com>
In-Reply-To: <154775022743.169631.1716489383315213219@swboyd.mtv.corp.google.com>
From:   Guenter Roeck <groeck@google.com>
Date:   Thu, 17 Jan 2019 11:09:31 -0800
Message-ID: <CABXOdTfE+_q8DrRfPE1V+3pU7x5rLoOy7k5LYMrwd+xojsBWvw@mail.gmail.com>
Subject: Re: [PATCHv2] watchdog: qcom: Add suspend/resume support
To:     Stephen Boyd <swboyd@chromium.org>
Cc:     Guenter Roeck <groeck@chromium.org>,
        Guenter Roeck <linux@roeck-us.net>,
        Sai Prakash Ranjan <saiprakash.ranjan@codeaurora.org>,
        Wim Van Sebroeck <wim@linux-watchdog.org>,
        linux-watchdog@vger.kernel.org,
        Rajendra Nayak <rnayak@codeaurora.org>,
        Vivek Gautam <vivek.gautam@codeaurora.org>,
        Sibi Sankar <sibis@codeaurora.org>,
        Doug Anderson <dianders@chromium.org>,
        linux-arm-kernel@lists.infradead.org,
        linux-kernel <linux-kernel@vger.kernel.org>,
        linux-arm-msm@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-watchdog-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-watchdog.vger.kernel.org>
X-Mailing-List: linux-watchdog@vger.kernel.org

On Thu, Jan 17, 2019 at 10:37 AM Stephen Boyd <swboyd@chromium.org> wrote:
>
> Quoting Sai Prakash Ranjan (2019-01-17 07:19:42)
> > diff --git a/drivers/watchdog/qcom-wdt.c b/drivers/watchdog/qcom-wdt.c
> > index 780971318810..5dfd604477a4 100644
> > --- a/drivers/watchdog/qcom-wdt.c
> > +++ b/drivers/watchdog/qcom-wdt.c
> > @@ -245,6 +245,28 @@ static int qcom_wdt_remove(struct platform_device *pdev)
> >         return 0;
> >  }
> >
> > +static int __maybe_unused qcom_wdt_suspend(struct device *dev)
> > +{
> > +       struct qcom_wdt *wdt = dev_get_drvdata(dev);
> > +
> > +       if (watchdog_active(&wdt->wdd))
> > +               qcom_wdt_stop(&wdt->wdd);
> > +
> > +       return 0;
> > +}
> > +
> > +static int __maybe_unused qcom_wdt_resume(struct device *dev)
> > +{
> > +       struct qcom_wdt *wdt = dev_get_drvdata(dev);
> > +
> > +       if (watchdog_active(&wdt->wdd))
> > +               qcom_wdt_start(&wdt->wdd);
> > +
> > +       return 0;
> > +}
>
> This looks fairly generic. For example, the Mediatek driver also stops
> and starts (but also pings after starting). Grepping for 'active' in
> drivers/watchdog/ finds more examples. Could there be some functions in
> watchdog core that do the common things like watchdog_stop() and
> watchdog_start() and watchdog_start_and_ping()? Or maybe a bit can be
> set during registration so that the 'struct class watchdog_class' can
> get PM ops to stop and start on suspend/resume of the watchdog character
> device?
>
> Nothing is wrong with the patch, I'm just bemoaning the amount of code
> duplication here.
>

Patch(es) to add the functionality to the watchdog core are welcome;
it should be possible to move the functionality into the core (maybe
to be enabled with a new watchdog API call). Doing it using the class
device sounds like an excellent idea. This should be straightforward
to implement, though the question of "should we ping on resume or not"
might be an endless source for bike shedding fun.

Guenter
