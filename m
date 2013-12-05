Return-Path: <linux-watchdog-owner@vger.kernel.org>
Received: from mail-qc0-f176.google.com ([209.85.216.176]:54322 "EHLO
	mail-qc0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757146Ab3LESfV (ORCPT
	<rfc822;linux-watchdog@vger.kernel.org>);
	Thu, 5 Dec 2013 13:35:21 -0500
Received: by mail-qc0-f176.google.com with SMTP id i8so5202305qcq.7
        for <linux-watchdog@vger.kernel.org>; Thu, 05 Dec 2013 10:35:20 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <1979723.ga7TBeh7CQ@flatron>
References: <1385613243-3559-1-git-send-email-l.krishna@samsung.com>
	<1468334.WxyIceyAAx@flatron>
	<CAD=FV=VKT2mdwNMeZrimurtHeqNBJcpbmZzXV1-es2DxKcFXqw@mail.gmail.com>
	<1979723.ga7TBeh7CQ@flatron>
Date: Thu, 5 Dec 2013 10:35:20 -0800
Message-ID: <CAD=FV=UcqaG9Dw_rd-bdTAmDwdW-_yCO6HpaEr1G07AW4TWm0w@mail.gmail.com>
Subject: Re: [PATCH V11 1/3] ARM: dts: Add pmu sysreg node to exynos5250 and
 exynos5420 dtsi files
From: Doug Anderson <dianders@chromium.org>
To: Tomasz Figa <tomasz.figa@gmail.com>
Cc: Olof Johansson <olof@lixom.net>,
	Leela Krishna Amudala <l.krishna@samsung.com>,
	"linux-samsung-soc@vger.kernel.org"
	<linux-samsung-soc@vger.kernel.org>,
	Wim Van Sebroeck <wim@iguana.be>,
	Kukjin Kim <kgene.kim@samsung.com>,
	Tomasz Figa <t.figa@samsung.com>,
	"devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
	"linux-watchdog@vger.kernel.org" <linux-watchdog@vger.kernel.org>,
	"cpgs ." <cpgs@samsung.com>, Guenter Roeck <linux@roeck-us.net>
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

Tomasz,

On Thu, Dec 5, 2013 at 10:30 AM, Tomasz Figa <tomasz.figa@gmail.com> wrote:
>> I'd vote for using "pmu-system-registers".  We end up using the
>> "syscon" subsystem but really we're describing pmu registers.
>>
>> I'd even say that you don't need to formally specify the "name" in the
>> bindings (though I'm not up with all the latest device tree
>> requirements).  ...still you'd want to use "pmu-system-registers" in
>> the DTS changes.
>
> Well, since the name should specify the class of device, I would say that
> pmu-system-registers is too specific. If we want to change this, I'd say
> we should go with system-controller.

...but the "compatible" is "samsung,exynos5250-pmu", "syscon", right?
That means that the class of the device is "exynos5250-pmu", right?
It is also compatible with the generic "syscon" class of devices.

> As for name specification inside the binding, I agree that binding should
> not require the main node to be named specifically. If we want to have
> another version anyway, let's drop this.

That sounds good to me.  So drop the "name" part in the bindings file
and then apply this discussion to patch #3 in this series (the one
that touches the .dtsi files).

-Doug
