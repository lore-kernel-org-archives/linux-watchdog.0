Received: from mail-oa1-f48.google.com (mail-oa1-f48.google.com [209.85.160.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD6FA33D512
	for <linux-watchdog@vger.kernel.org>; Sat,  5 Sep 2026 01:53:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.160.48
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788573187; cv=pass; b=RTMbu2dxFzDZjOG/1GLjTrtIOWHaSvuODE7dSAIKsLCJU3BWPqNrKSytnKpxthWpWJ/rdzs17VnMp5hlK1NyhzC01PQHVV1KjRh/NFwoyhZNHwIyHIToOK5ev9Rrfj6zFMmi+ewuHdufzOGcJWhfJQCUxvT81GvdO3+9LOj4j+c=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788573187; c=relaxed/simple;
	bh=Wpt7DuNPNgIESG4CCHysgiXD1WUySeU8KIWxMrrs66w=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=gu2L/7cnmqW1yeW3mTrAbg0cJge+P+vlDXtTsNJImlXwRelZuN1K6U39FtzWgkBH7+ZraaSYNGWGc2b1LWK6QshJMpdpjw22uRNz9IcZJX2FEHJzKdzAjETiyOlkJFzqYMks//Dw1ttf7s6tPgojBr9NKz1XMG3JwrCuzoooqik=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=u2w1n9Rd; arc=pass smtp.client-ip=209.85.160.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="u2w1n9Rd"
Received: by mail-oa1-f48.google.com with SMTP id 586e51a60fabf-46556b9e02cso1276292fac.1
        for <linux-watchdog@vger.kernel.org>; Fri, 04 Sep 2026 18:53:05 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1788573185; cv=none;
        d=google.com; s=arc-20260327;
        b=Oj0BcAIUJs/J9nD6emTDN6hMTfjk6YICl/cMM5+3gYTv6ZfqUs2pUxiIf3SQNTcWAe
         id4Du6A62BY6jDr3+jrJQLgK0jVAbcwadx2HO8IEuv6HglTi+JTeBIW30CXhzlFNYWNh
         du8bGJ9VDMiJHgnOfwz/D6MnnZcesQXkpNba13INybz3uOtX3AdYaerb4ZG3PaALB/52
         ApBe8v5tEs3Ws+s9nM87/SHAz4Xl8S+dSUL+xpwjljSwNkJiwVRoP2JVM7hd2bcSyAxB
         CEt2GiNXizoA7eLE3u97etmfxqiaiz3hXJHNyijjx/vq8Yi7mp3vdzCaxDfmtBkjFOGI
         nVIg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=Wpt7DuNPNgIESG4CCHysgiXD1WUySeU8KIWxMrrs66w=;
        fh=lg6zyOtVS+1s/vOkTcNKLAAs4qy06cLn3dQzTrkgnZk=;
        b=Z7uSZ9bmpRcf03STWsPvZyKz4iidKqqlbgm8mgjw/PUcMH6G+S+wc2Vj5CenwsodvD
         wdgZZGzJt7ywAhU8FfXi8KQej3AyKNP3SjPZjCTyWTVk0O6kHmixg19TL0SyQGWrnTEN
         Izz1bs4eZyW1P+8pEjTawoxSWTOL+PfAlwmTT42u4fsQSW6WCGM9//cVJifY8p3Z7d64
         C4d4hmGZZ1CShxhPOZFALyYNTf5bL+IjIFFO7W6iVpcQebhI69JOHkNB6XA1KXhXtXmY
         c8ZMYpZqjzab1pew+q7o/vZ5leKBMCH0NCtNyj2SkS8uiXzsB+A+MuBujr+Y9ifllY2F
         Lpqw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1788573185; x=1789177985; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=Wpt7DuNPNgIESG4CCHysgiXD1WUySeU8KIWxMrrs66w=;
        b=u2w1n9Rdm/fi/caIGnIJx1DRzbOe7hXOBTsRChqCiUM63Hmn2SmGx7ld53tl0Pk8iD
         msb4f0eIhRBoLiWGCC6z/CmdAy4aEnAjj2ND+soRG8eA/8ESb68wlMVTp2FVJr735X8p
         hgAv3r3adoX3U3EIxoFOOsL6T7miwgPpTW2GyiRZ7d6XghS/qHattMuFvANXCUUy7T0O
         fMFhFnt/RwAuqSiQMtMHlqdj9ItJKrXjvvyzK0ae6t5AUK0q4dAVdkhcfpLrNB2b+ee3
         cJbzEM0ZOPEIOdV6avlXpfpZZ6I2b17oxZhubFX1BuYeVr/MqP5KJDodaL7tv6gd7JFi
         A8DA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788573185; x=1789177985;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Wpt7DuNPNgIESG4CCHysgiXD1WUySeU8KIWxMrrs66w=;
        b=kOJIe5cyN/HCouN3hEFXO68pIXrjeix9Fqzn4E7Vwg7EREvodywvdrwLK62bdoOBMB
         qRLDx8jcbBvafgZ+7jPm9YDVPE5lSPTHelJojwkDkSYfnvr6V6TyI8oqtMYyxlilU1dx
         J4IVAOzIAAtvUitBNkcyjOSAfVgpkOs8vA1k+eCP3y1BXRugTvAENIMcTF6QcTPkGQet
         cIJuLUsD4nU7nqQfZs4y+MpuLF4J+xh47NQQwDgxAr0v3VuIXE/FgHC3R9LCJQVvkcc7
         EMEqqJQlO/X72Yj/OLmTpTICWBSxsLlJUbVxNSVNUJqev+B17TVEAfcHCzTkhrEmp6Ki
         yvvQ==
X-Forwarded-Encrypted: i=1; AKwUvBxQmr5NPsr19JZ4b3AyayOcJ7D1nUrVfMiNEx868MTWlzGaNLYiFmsoO7I8LxDwsS+q/d6xetmmJ9PWIneUAA==@vger.kernel.org
X-Gm-Message-State: AFuF++nrD0GVSNsyMMjH+MUE32oSQsWf1pn9DPie1FEmN1bInmMCl0gZ
	ZMtZuz3jvyq5Jmj+Fi/SGrlm0tAGuFPwbweFtr95rqNHKGou/XUO7H8CH0/ehLa7bRLl5i+WB+K
	O3FocnyuZJdYV3J0UjBJpTUvX/ZYkjJAweO7+zaWLds3fg6agvoJYVK+gMfLwXw==
X-Gm-Gg: AYBFou2qDmFtdzjcn3rXPYasEuAU2ooyjg2QHy8VVVY34NZINshYzkYRHxbBthUbzR0
	VynsmEipQ28NacX5fefH4DJXXICD91LLYJjp70qa7ceNWm/OdJ3H9JRb3lNALgUi9/XBpzitU2F
	nIDwaJiyaBMajS319vmD7Kz0zjs+PYaUL9jn5+mprhbXwllaTjqOnkZAw88b2w+PenjNHQhJJ5U
	wRWs9fGjXuEPaXeiC1wUtdNDPydod5nzlQFIvRSuUcsAy/giaod0cGn4/UZv6KAcZMGqbNPStx7
	LncyA8nkS45tYJazto8DYy95DQwIxLYpD17KZXihS6czcjTSyQE5Fm/XhqiSXCrXm+MRGoOo84S
	7uw==
X-Received: by 2002:a05:6871:552:b0:470:e97e:8f89 with SMTP id
 586e51a60fabf-470e98e3742mr5556974fac.25.1788573184127; Fri, 04 Sep 2026
 18:53:04 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-watchdog@vger.kernel.org
List-Id: <linux-watchdog.vger.kernel.org>
List-Subscribe: <mailto:linux-watchdog+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-watchdog+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260902-qcom-wdt-nmi-series-v3-0-f3999362a9ea@google.com>
 <20260902-qcom-wdt-nmi-series-v3-3-f3999362a9ea@google.com>
 <87ecf98ivn.ffs@fw13> <CAD=FV=VMExH-K68aDfNsFBnQRSaYSNwbHo7hLhpzhpWN+r+Fsw@mail.gmail.com>
 <87y0dh6oqe.ffs@fw13>
In-Reply-To: <87y0dh6oqe.ffs@fw13>
From: Mayank Rungta <mrungta@google.com>
Date: Fri, 4 Sep 2026 18:52:53 -0700
X-Gm-Features: AcwNN1VPx2heUjeMS3C93bR1ek6ti7FrnovSxIJqv1HXxVhsBQVkdAztmW7cHPQ
Message-ID: <CABz7rdABFgW-cQ3qJC_=Q2uJZvc-JxJmUhokBztF82RUdJk7vA@mail.gmail.com>
Subject: Re: [PATCH v3 3/5] genirq: Export NMI APIs
To: Thomas Gleixner <tglx@kernel.org>
Cc: Doug Anderson <dianders@chromium.org>, Wim Van Sebroeck <wim@linux-watchdog.org>, 
	Guenter Roeck <linux@roeck-us.net>, Radu Rendec <radu@rendec.net>, linux-watchdog@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org, 
	"Kirill A. Shutemov" <kas@kernel.org>, Marc Zyngier <maz@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Sep 4, 2026 at 8:05=E2=80=AFAM Thomas Gleixner <tglx@kernel.org> wr=
ote:
>
> On Fri, Sep 04 2026 at 07:07, Doug Anderson wrote:
> > On Fri, Sep 4, 2026 at 2:29=E2=80=AFAM Thomas Gleixner <tglx@kernel.org=
> wrote:
> >> On Wed, Sep 02 2026 at 18:54, Mayank Rungta wrote:
> >> > Currently, request_nmi(), free_nmi(), enable_nmi(), disable_nmi_nosy=
nc(),
> >> > and disable_nmi() are restricted to built-in kernel code because the=
y are
> >> > not exported.
> >> >
> >> > Export these symbols with EXPORT_SYMBOL_GPL so loadable kernel modul=
es can
> >> > register and manage NMIs.
> >>
> >> I'm not really fond of that.
> >
> > Is this to be taken a NAK on the whole idea, then?
> >
> > The last patch in the series [1] wants to promote a HW watchdog bark
> > interrupt to NMI. This seems like a pretty useful thing to do and an
> > appropriate use of NMI, but the HW watchdog driver is a kernel module.
> > Do you have another suggestion for solving that?
>
> I understand the intent and why it might be a good idea, but letting
> random modules convert interrupts into NMIs is a scary thought.
>
> We can export it in a restricted way though to limit the exposure and
> force people to go through a thorough review of these use cases.
>
> That could be a subsystem restricted export or an explicit restriction
> via EXPORT..FOR_MODULES().
>

That makes sense. Do you have a preference between
`EXPORT_SYMBOL_NS_GPL(..., WATCHDOG)` and
`EXPORT_SYMBOL_FOR_MODULES(..., "qcom_wdt")`? Happy to go with
whichever you prefer for v4 (which I'll hold off on sending until we
reach an agreement on the NMI teardown discussion in patch 1).

> >> Funny enough there is already a driver which claims it can be built as
> >> module which uses these interfaces. Oh well...
> >>
> >> > Assisted-by: Antigravity:gemini
> >>
> >> I'm impressed that AI is required to add four EXPORT_SYMBOL_GPL()
> >> instances.
> >
> > Hmm, I guess it's hard to figure out the guidance here. I think Mayank
> > is only adding this tag to try match what's documented in
> > `coding-assistants.rst`. If you've got an AI helping you with a
> > series, it's pretty much touching all the patches. I guess you're
> > suggesting that, even if AI touched it, trivial patches should remove
> > the tag?
>
> I really have no strong opinion about it. But it just amused me and I
> couldn't help my self from commenting.
>

Actually, I was able to add the first 4 exports by myself, it was the
5th one I really needed help with! :)

Jokes aside, since the whole series went through AI review and
different maintainers have different expectations around AI
attribution right now, I conservatively added the tag across all
patches. I'll drop `Assisted-by:` from trivial patches like this in
the next revision.

Thanks,
Mayank
