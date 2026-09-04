Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C5454A2A65;
	Fri,  4 Sep 2026 15:05:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788534358; cv=none; b=BBQqbh+Zu0B/Ey8oNnZr+EV8ZC6VnwTVgi173zg3MZmvreKi+q4VKdoFgOYGj80HJMKd1Qq9gJlizzHR+CnHp9Gf14aYma0vtbNrv1ep1SCjbKWH92HPophvCvXwp9frAF3yYnk2tLBnc5Rl63PVRN1m/KNLcEPEvkyqdxd96Zs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788534358; c=relaxed/simple;
	bh=cvlne63BbiZ6RD2newI5QrPXiEQd5qJ7/aO+WLY4d8M=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=lUQVVCz0iEcbenAYF0gqId7HajEVXDHA3TWQS+l/aIXyfQAsyWae58wFwtR9V2a2gSE3nJ2GING2FRPphNS4FYBGVPz4XKmf85lBcLglJARN47Axf3JyyvsrNFB591OUx2rKeNFxSLARuWFAu+UDdQvzRfNumaKdlD3P9Z2An3M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dvh4BTqs; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dvh4BTqs"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 18DDF1F00A3D;
	Fri,  4 Sep 2026 15:05:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788534349;
	bh=ZdoZOK25d3S+VRV+k2N9yh/rrgWBljAQIjGYofH4lzI=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date;
	b=dvh4BTqsfO5a8o97Jw0nT5RRJBNHPC50v91pcqG7adTzYmgNrWuXTYVgbetspMTVF
	 GeHfYDC8SdMhR4itYstujRA9XPgSqN6/fCBv1xJ+xMgGuGkp56hbS6QMxxOAW5Ruxt
	 XbH8/v4wAaIv18obFpNif4j+VUYtjLkO6dCVIL3Pu1tsUWGbg5QLHYcBjUYCAXd52C
	 Tzfdpd+uAYeUrCCNz4qTGiriaesf9U/X64zGUWbIlOVfCsM+JimdQU2cqS7RrU5NsH
	 JdFFJ5KJy6lUo6F7IiU1rOAcpHIhZGUf3ipLKJTO4VQ+7jGdPkuoZJEpK85dZlci0H
	 s01Q7408DySmA==
From: Thomas Gleixner <tglx@kernel.org>
To: Doug Anderson <dianders@chromium.org>
Cc: Mayank Rungta <mrungta@google.com>, Wim Van Sebroeck
 <wim@linux-watchdog.org>, Guenter Roeck <linux@roeck-us.net>, Radu Rendec
 <radu@rendec.net>, linux-watchdog@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org, "Kirill A.
 Shutemov" <kas@kernel.org>, Marc Zyngier <maz@kernel.org>
Subject: Re: [PATCH v3 3/5] genirq: Export NMI APIs
In-Reply-To: <CAD=FV=VMExH-K68aDfNsFBnQRSaYSNwbHo7hLhpzhpWN+r+Fsw@mail.gmail.com>
References: <20260902-qcom-wdt-nmi-series-v3-0-f3999362a9ea@google.com>
 <20260902-qcom-wdt-nmi-series-v3-3-f3999362a9ea@google.com>
 <87ecf98ivn.ffs@fw13>
 <CAD=FV=VMExH-K68aDfNsFBnQRSaYSNwbHo7hLhpzhpWN+r+Fsw@mail.gmail.com>
Date: Fri, 04 Sep 2026 17:05:45 +0200
Message-ID: <87y0dh6oqe.ffs@fw13>
Precedence: bulk
X-Mailing-List: linux-watchdog@vger.kernel.org
List-Id: <linux-watchdog.vger.kernel.org>
List-Subscribe: <mailto:linux-watchdog+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-watchdog+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On Fri, Sep 04 2026 at 07:07, Doug Anderson wrote:
> On Fri, Sep 4, 2026 at 2:29=E2=80=AFAM Thomas Gleixner <tglx@kernel.org> =
wrote:
>> On Wed, Sep 02 2026 at 18:54, Mayank Rungta wrote:
>> > Currently, request_nmi(), free_nmi(), enable_nmi(), disable_nmi_nosync=
(),
>> > and disable_nmi() are restricted to built-in kernel code because they =
are
>> > not exported.
>> >
>> > Export these symbols with EXPORT_SYMBOL_GPL so loadable kernel modules=
 can
>> > register and manage NMIs.
>>
>> I'm not really fond of that.
>
> Is this to be taken a NAK on the whole idea, then?
>
> The last patch in the series [1] wants to promote a HW watchdog bark
> interrupt to NMI. This seems like a pretty useful thing to do and an
> appropriate use of NMI, but the HW watchdog driver is a kernel module.
> Do you have another suggestion for solving that?

I understand the intent and why it might be a good idea, but letting
random modules convert interrupts into NMIs is a scary thought.

We can export it in a restricted way though to limit the exposure and
force people to go through a thorough review of these use cases.

That could be a subsystem restricted export or an explicit restriction
via EXPORT..FOR_MODULES().

>> Funny enough there is already a driver which claims it can be built as
>> module which uses these interfaces. Oh well...
>>
>> > Assisted-by: Antigravity:gemini
>>
>> I'm impressed that AI is required to add four EXPORT_SYMBOL_GPL()
>> instances.
>
> Hmm, I guess it's hard to figure out the guidance here. I think Mayank
> is only adding this tag to try match what's documented in
> `coding-assistants.rst`. If you've got an AI helping you with a
> series, it's pretty much touching all the patches. I guess you're
> suggesting that, even if AI touched it, trivial patches should remove
> the tag?

I really have no strong opinion about it. But it just amused me and I
couldn't help my self from commenting.

Thanks,

        tglx
