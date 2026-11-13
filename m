Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.160.182
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794550339;
	b=2jmm/83bR9pGlrt8zOI2ag+K+ZWQ0JtH96BymTeA2N5Yb6XcKa+5KbbmVOx52qUZ5Cmq
	 am2DubMj9AcHCbvWBamPTErfE2/JFrUXJVg8RcPdSyFirtRCsnCM//mdvZtTsPUGFSwiB
	 BZn3eyG887i0DFeb3XpwMsaq138xRIqcXu78gQp52dSGb/mDyzFrE/OkgEhAiezy9WLND
	 MzaPXxGoXML8KuLNw0gNcPp6T4kkzD/x1IiHOS227d0sAvr4hKnu+XhrNFhgUhxUkNdn0
	 eBzK6kVz/2UDUXz0yjvB/GOtJ/cMhkENXpjZ8pf1jLLnMCygZ5q9cdBUCmZRifdU2JQ==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794550339;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=wix08yJ27yJSgUGKEpKBIXQFAmhik0Hn4X6nmBhrer0=;
	b=0/S7BMBaI7OOhchZ3tt6B8t6zS4nYEXxZKqf2m5w6IbILKwZ6boUaT6N0YU/V9xg9I3g
	 5QSFaFCTCwmjxsg0gD/hCgx34lhafC7qvFeDpocqDRlA+KD8l8i1ONU1BH3JhVRtepk0l
	 9OXNXhMrPKTj/bv1t626yuTzluaaNyW0TJeQFxiNM4Iv1g72Y/q7Kj0ng3vtD8FKl05Z2
	 IYNq9Bu1AmqVo4dYmEssGOfINR0kIgeSHkCbZgvRfo1MgIdEnxlaG5hueyLrcMhEMcxHh
	 ONFBXAAmDRQ6Oawczwwqvi6d8ryxYtA0KKb0U5p8JhAyIkaAo19/Rwe5U+NjY2mUWxA==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b="K/0eFjpv";
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.160.182
Received: from mail-qt1-f182.google.com (mail-qt1-f182.google.com [209.85.160.182])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C8CF6606A323
	for <linux-watchdog@vger.kernel.org>; Fri, 13 Nov 2026 06:12:18 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org C8CF6606A323
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=K/0eFjpv
Received: by mail-qt1-f182.google.com with SMTP id d75a77b69052e-533861a59b8so12365981cf.1
        for <linux-watchdog@vger.kernel.org>; Thu, 12 Nov 2026 22:12:18 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1794550338; cv=none;
        d=google.com; s=arc-20260327;
        b=gcVDMkWco0JAarKnfzTd9J3kF1MSchdU9/CR79jclCPa9BirwHRpiU5EtIS6bjhC+l
         uT3nutSxJeq8nYhlfPxbQeN/d9rIAGubLm3e6OGWt+3H/CWM3YAPnl/fboTg13DecLqw
         SGhyf76iHv1MU+0IzxHdgTMV5dbDxspzdqhi7u9lwkRYGjQ6Qeo6Fj8EKIPCKlknvsPi
         do1R59wYDRUlSBTLyCQDh9r+9zO+l71uBvfEkLbj3E2p1PLIYxaVe0qvCS1qqvhLc7hV
         CnSmsR0FUTavtdLEZchUV310qygV+6s+k5AZIbCAlua7Lv7KgAcDMlX5eY7SnSfUDT0M
         SNAA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=wix08yJ27yJSgUGKEpKBIXQFAmhik0Hn4X6nmBhrer0=;
        fh=2VavGFrEcWbABH1yIte526UuT9hsZxN0+Y92fgGUcTY=;
        b=BxFbOYquN9a92ZdpzM927LMi/lkQ8yxWf54XS84x0yxTIMuGLynqVC2g2wGmlKfsW4
         +ZfZgqy2taM7A+61CwqAHFxi9R6nKziA9UcuQfipr/bWXXFH0CrhNYzzj09hwUIMrVZm
         vTH7NoGi/OwyJ5LmZygcz7DWdEVkyJUwPBwWmfd2fD2UxPgMsjpx2qEcaw3a2m/0mwjE
         8AaZX2SPgidkbx3VOyqL5GRQZn5QsKQnyOCn43zRA5yHvOIhEqSe35SFywOC6D/EDtHW
         asVnFqxMHXT9UP6vhRV3on5ffmCZjOR11QJHEjAVWjSuSeZAcLMXSrBM2/Xxg0X8HzGW
         eURA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794550338; x=1795155138; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=wix08yJ27yJSgUGKEpKBIXQFAmhik0Hn4X6nmBhrer0=;
        b=K/0eFjpvzXRSCb2fpPDOu+bop1EryR1QDD6CFRfcHjjvXvNaImzDm4ccf4bbCLuJcz
         MihCQ2X0ovfL/OwDMjc6hOAHxZwnjN4shUIlADoEINN++alojAZmVG7sUBKi432CsJvX
         HO6MJwbdVzA8TfKzh9tTWES7zHdre47xug8SgpfQ1+Bp06/SK3CKZ5w6OVPOZxUP5BnO
         LtwomroZYTbzGohnPpRd9z7avb+4YRqP6Tw/gu8Cqb6u4HfRqQJVskqqZ301aABS1ANf
         JZdDm83iIiSCv87druGLHzoLt6w+OeONzwrP2si/6XXaaGDdYEOvNCk5e7tkGByswr5x
         pn2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794550338; x=1795155138;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=wix08yJ27yJSgUGKEpKBIXQFAmhik0Hn4X6nmBhrer0=;
        b=ai9S+45kYXfyIpu2hlvRXMoa+uLOi9zOqOthHK30FmCszgiaT+kER93EqyKZw0eY73
         5SmodEjDKAS90p/FYk2FFWTG3OT+6zB7cBa4QeJAVNLOt4cwNzQh4BIEU3Q5U6i8oADi
         cRxqbYej9xklkZOL9kpwmWqB1ng1UBr2AeBoI7BW1T25NDiK4TDLXgVcKinPBJc3Roca
         x/H/XQbpETpjOdjXVVVo1DclMcjzSFwOz2fTxMwrsuoQXMRfjKMEhccn9vIrQVPfmlXW
         d3/KqNohYeil2YHAckJXPRb+J7FX/jaIFpzjwxhBEDCEHFLBMEfEIqiu5nnrMbqrhf+0
         lhUQ==
X-Forwarded-Encrypted: i=1; AL+hErGwEIaZFfBPxVMObZmRRsWtsJv+72RX5AgENwdAgck8QQO6HLWEADHQDcZewPDfsWy5CTvvFvvng/cW4CxHDA==@vger.kernel.org
X-Gm-Message-State: APuU4Z9xRSEur/XWXVuMrTQOLImNGf26Y2pthRducfWfuPvpgrralF4V
	Yp/d7dWyTpchjo8lXcXnX6ProrBCs3753NhkNby3xPuAmQ3O7nuiZ9lcwrBNIrC7zl8S0TTwJaA
	EorYeL7gOHXFGdPQURPLd5FfUs4Xv3uM=
X-Gm-Gg: AYBFou2GiKHEvh+m3l7PzplUz7mNvhRYD4qdpPs4h59Qpr5oJdSMqEr3UnykbL8dwXf
	ySi2dp/i7ORMdXOsqQ3akD9jcypt1adQRKfsY0O10Ts+bXMnYiLG+mrOvBMc7esUmLxf0W/A3Yw
	jNkWnJBDzCOwDeQ81ydmzVOEnRn0f4UsEI1kcQ5T2+n1aGbJZ4UIK93exZ+hdFDlrNBcSqs2gUa
	u9CJppkfeWkitucwHf0JeQiNk2/rJ4zbkSY+m6gP03vJS609knlItCsCdna8F98KJS+IGASyfF1
	is9ZNw4xQBuL/vNq7fALrzlKcGOz05rLM5YgDRuGQnEqqI6qi25ih2jSeavNo7rRPxgBJhKBcNc
	JPAcZ2HqrJvaeVaf9ntU1tNc3J8lit1BQKk94HtMDglxQijwu49ZhHk0yqNEyIYQBOdos
X-Received: by 2002:a05:622a:1813:b0:536:43ea:f876 with SMTP id
 d75a77b69052e-55ac4391cd0mr29866681cf.5.1794550337807; Thu, 12 Nov 2026
 22:12:17 -0800 (PST)
X-Mailing-List: linux-watchdog@vger.kernel.org
List-Id: <linux-watchdog.vger.kernel.org>
List-Post: <mailto:linux-watchdog@vger.kernel.org>
List-Help: <mailto:linux-watchdog+help@vger.kernel.org>
List-Subscribe: <mailto:linux-watchdog+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-watchdog+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-watchdog+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261112-vt8500-timer-updates-v6-0-fd1cea645d1f@gmail.com>
 <20261112-vt8500-timer-updates-v6-4-fd1cea645d1f@gmail.com> <468e51cb-5852-4c8a-938d-bda2aca8c83e@roeck-us.net>
In-Reply-To: <468e51cb-5852-4c8a-938d-bda2aca8c83e@roeck-us.net>
From: Alexey Charkov <alchark@gmail.com>
Date: Fri, 13 Nov 2026 10:12:06 +0400
X-Gm-Features: AclHuK_xoF4t3_XsXjyB9Y-lmiPCHjRTiY27rZQBkq_kf73XFRERFEk1oNbXQx4
Message-ID: <CABjd4Yz_GNpXoUa5YTRJLvy6bLWDP+Qtc4Oges=mX4pjC-fBdg@mail.gmail.com>
Subject: Re: [PATCH v6 4/4] watchdog: vt8500: Add a restart handler
To: Guenter Roeck <linux@roeck-us.net>
Cc: Krzysztof Kozlowski <krzk@kernel.org>, Daniel Lezcano <daniel.lezcano@kernel.org>, 
	Thomas Gleixner <tglx@kernel.org>, Wim Van Sebroeck <wim@linux-watchdog.org>, 
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
	linux-watchdog@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Nov 13, 2026 at 4:44=E2=80=AFAM Guenter Roeck <linux@roeck-us.net> =
wrote:
>
> On 11/12/26 10:55, Alexey Charkov wrote:
> > Reset the SoC through the watchdog when the machine's own restart hook
> > leaves it running: the PMSR write in vt8500_restart() has no effect on
> > WM8950, so a reboot there ends in "Reboot failed -- System halted"
> > unless a watchdog armed from userspace happens to fire.
> >
> > Arm the match a millisecond ahead of the current count, which leaves
> > ample margin for the register writes to land.
> >
> > Register at priority 128, the default for restart handlers and also the
> > priority of the ARM machine restart hook. That hook is registered first=
,
> > from setup_arch(), and handlers of equal priority run in registration
> > order, so this one runs right after it and only matters where the hook
> > fails to reset the SoC.
>
> This isn't really the idea of restart handlers. The sequence should be we=
ll
> defined. That is what the priorities are for. Why not give it a slightly
> lower priority ?

My thinking was along the lines of "I don't care who of you guys does
the job, as long as it's done". But now that you've pointed it out, a
watchdog reset is probably more rude than some other method, and also
requires waiting for the timer to expire, so I'll probably switch it
to 0 to make the "safety net" connotation explicit.

> > Signed-off-by: Alexey Charkov <alchark@gmail.com>
> > ---
> >   drivers/watchdog/vt8500-wdt.c | 13 +++++++++++++
> >   1 file changed, 13 insertions(+)
> >
> > diff --git a/drivers/watchdog/vt8500-wdt.c b/drivers/watchdog/vt8500-wd=
t.c
> > index e0f838fd1d50..0ce1e2b06410 100644
> > --- a/drivers/watchdog/vt8500-wdt.c
> > +++ b/drivers/watchdog/vt8500-wdt.c
> > @@ -25,6 +25,9 @@
> >
> >   #define VT8500_WDT_DEFAULT_TIMEOUT  30      /* seconds */
> >
> > +/* How far ahead of the current count to arm the match for a restart *=
/
> > +#define VT8500_WDT_RESTART_TICKS     (VT8500_TIMER_HZ / 1000)        /=
* 1 ms */
> > +
> >   static bool nowayout =3D WATCHDOG_NOWAYOUT;
> >   module_param(nowayout, bool, 0);
> >   MODULE_PARM_DESC(nowayout, "Watchdog cannot be stopped once started (=
default=3D"
> > @@ -75,9 +78,18 @@ static int vt8500_watchdog_stop(struct watchdog_devi=
ce *wdd)
> >       return 0;
> >   }
> >
> > +static int vt8500_watchdog_restart(struct watchdog_device *wdd,
> > +                                unsigned long action, void *data)
> > +{
> > +     struct vt8500_wdt_info *info =3D watchdog_get_drvdata(wdd);
> > +
> > +     return vt8500_watchdog_arm(info, VT8500_WDT_RESTART_TICKS);
>
> This sets a 1-ms timer and doesn't wait for it to fire, so the next
> restart handler (if it exists) will be called. That seems odd,
> and may introduce unexpected behavior. Is this intentional ? If so,
> it should be explained.

Not intentional, thanks for pointing it out. I'll add a wait in the
next version.

Thank you for the review!

Best regards,
Alexey
