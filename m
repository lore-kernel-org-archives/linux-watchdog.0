Received: from mail-ot1-f54.google.com (mail-ot1-f54.google.com [209.85.210.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C2F3D4219E7
	for <linux-watchdog@vger.kernel.org>; Thu, 30 Jul 2026 23:39:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.210.54
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785454770; cv=pass; b=A3YB13eT66mXkK5Zfi0nX7HYEIL5yiWh+SJ8dbbSGQu/BwqO+CskTwqfVy1xF6gEGNSpd1nE5fckqzm8ZXkUTWGJfac0wxctzZLIBDV4PSg3byxXCxNqaihNqyJSmoQH7TXf73dgxIntwsUsQ5+GIpt54PO3uOVHwuc2Fdpkm+Y=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785454770; c=relaxed/simple;
	bh=uWYChakUuwek8eibgmmJR9Zj3TvJ6TkwMHpcQpNoWsU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=a68jZ+2ozuVxMq1uU9CkOU8UDrXlz95eoIMp8pDEsxml49L5BIzDMla9p3L3MZsIFuQqlIwXr6N62sU368Off4re14Cf0LO78TuRn3aJSLh1BxUxC+p5q507Kx6g53biIFpy+vrTrDCJJy702QSDUviwb4D0twLf9RE0woZ+Qrk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=t1efqXyh; arc=pass smtp.client-ip=209.85.210.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="t1efqXyh"
Received: by mail-ot1-f54.google.com with SMTP id 46e09a7af769-7eb64085c45so303839a34.2
        for <linux-watchdog@vger.kernel.org>; Thu, 30 Jul 2026 16:39:28 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1785454767; cv=none;
        d=google.com; s=arc-20260327;
        b=FDxZ3t8s3tEiNSPnhb7jd0wGcawNlzlXQexceu5WtD6Dwx5Oj/nrWkGMbY6haqEZ5t
         t1qA07CwJC9mlYM7H8Gehmh0iM1iiWsAbU77M19i8bEr4YwWE59W1BrPH1aj8lkpXfvl
         DnovpEwx8Ens8xSeGvseubxP8eW4TZNl2bQ3QhxdJBI0k5LLcfn0CaD2nsUoOTTtuJTE
         B9aDV99D3tYtPAL/YXinjSh+59BzdjrWqK6j9guG/jvcjWK+EmD7a8biwqjstmUyi+Zh
         miLRHcfbCW14DfUcwJWiB2IIvadwKATlUn5bcHPfWsDtl1D/5PqQpKsxmliYrm4s/jnU
         /wZg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=jYH9Ab+rNx8wOPy2rDWzwA4cOpvKadpdamnekEua3ik=;
        fh=GdTkLi9Fz67EtubzjgyjKaij+ekcU9LsKKLz8z+Xwtw=;
        b=LYGKyBEPHsiqPBlVTHokCiPN+yVEbddE4h3wRd9dFgPDp7c8Ls154/vRlZ/draXI3v
         rodbgSh6YAUB8DILnjcA+1dmV9PIJ5TlmAULHYPtUY2WPsyH4re5lM0nzrT/201Jn5gj
         QzFraeAtlfklPqEN87LkvjBRBVZU0uhkKT1VGVYjGjrJnRRvVSq3OefBYui6DSLyMFol
         gebVS4Iped/X2RK930kQHSlV5k0EDQj8DjbvoJbkxM/31hP78kw4O0SfsThb18xSKYEr
         WzJcFlH7SLE8fmCijRvApn3cwnM0K/cI++qx02cQV3uFa85nLAgBqsbE/vWXRpW/8bQD
         ZT1g==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1785454767; x=1786059567; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=jYH9Ab+rNx8wOPy2rDWzwA4cOpvKadpdamnekEua3ik=;
        b=t1efqXyheYxPtX80GdCYHvXuLMYVnZIeAmnWnSckClQce3eRyGJ67nPmq8xVDQgwca
         jOYtd1QeQ7yGHMsE42mFFxZGJbW7hhB0BRTKG8d+3Ppzwco6/6pVl9supEEA9zHtfa8X
         xDGWHGhIb6aSn7fKTWhXj8gbRaJLg6Vbhy7c9GggXcccH9l2iXhqfsZF/ae0P+jbJNe8
         YTb96nPCIztznc/Gn8r1uqpI/DqpnZ5AZ0/+bFYstzm//AzONJZWw3vj5nJe8bAY86GE
         cYQSznfNenSvYmlDQXME1u6Pcy7PnnW4ySCECBRUEZlNnBAQIU7JyUCPOt8dMf8b82KH
         x9Qg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785454767; x=1786059567;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=jYH9Ab+rNx8wOPy2rDWzwA4cOpvKadpdamnekEua3ik=;
        b=p3K1te7klGfF8kVBxqvDBGB9T+jn+Xh+ttYGNjrHJlwWm7iADBFhdi6M+B13fFMBtr
         yOtdBHLu4qHogJUwGgGXrw2XMIljVyUy3GUffMDerLeJo4K/gX9TOjnTfefBrrqJH+hp
         wCKdYdl9lnpQum8xJeOCX6mid2ybyHp7bEumqhc7GFUUXekVuKtHZcVTWCq6Y5sN54do
         aISb94CPCd8qClu/t5dLL2xsFlvgKc8PZvfSv9UqAmmTvVTeFOct8DRWJvJrcaXIyUNH
         vfKGngwNNd9HQ/6dMar0GcC8MJtYgyYkaB22vFYZ739lkSIouqqKoCMucunuOQI3NJsO
         ns2A==
X-Forwarded-Encrypted: i=1; AHgh+Ro+LprNzNRZMbsRZ5SZM+bWa13ZwJPvKSR4vPpC7CTYczINyENzIeLXK9SvcDBY3rdHB7m+Wiu4CWqF//YuLA==@vger.kernel.org
X-Gm-Message-State: AOJu0YxJ4RvifOeTu8QqQ/jktyOxRFShMsJDg3qTADtD87tfUQbsGqD/
	fGF9jF2O00hNZ5iaQv5KiZjEcC4X9yr5LRzpp5+WLCVsf/Bk1OTpcBEJAe77+MHjI9G3bXxsWON
	G+SkLPa/F+equeCVuJJ27fzJ1MTzSKac74Dz2853v
X-Gm-Gg: AR+sD13W1016ZVhNE8a9JlL3hQHKXhoT7vZj1jGGTeJcil/R4qf8VteOdCHlGVsSxyH
	WKSpan7OdJBca9i6nEmnioZq23LGgL5TJ03KaIGmEc8QkjLcoE1BKiyUasw8eSOXZgVWz+5247q
	bqf/BCbsQ3jn9R4BscRXFcR9FnTg1EXD4BHCjUjyfsEfWj2NPtLUf09ucuKf0PMcQEuZVREc034
	JHbf8KxlhV2cxwTSgx0A1nFX1tnQWtne1qN8RpOwSWsG85Mnf1pqAALxNe/Gv5BdxSgX8A39rBg
	d6v6zNsQrOhc4ImjOdqEP7FmGmAeLRLe5vtLfEYA+34wr8xMWTeTP05KcDjDlNEb4H8LlAJF51r
	B
X-Received: by 2002:a05:6830:6ad7:b0:7dc:cdea:7d9 with SMTP id
 46e09a7af769-7f02c1c2c6fmr3502017a34.22.1785454767092; Thu, 30 Jul 2026
 16:39:27 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-watchdog@vger.kernel.org
List-Id: <linux-watchdog.vger.kernel.org>
List-Subscribe: <mailto:linux-watchdog+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-watchdog+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260730-export-cpu-backtrace-apis-v1-0-bace8e1cb817@google.com> <20260730155021.8252ad9d155b472702e66755@linux-foundation.org>
In-Reply-To: <20260730155021.8252ad9d155b472702e66755@linux-foundation.org>
From: Mayank Rungta <mrungta@google.com>
Date: Thu, 30 Jul 2026 16:39:14 -0700
X-Gm-Features: AUfX_mwwGzCyylhoOPtrLtp4YhI48Cis3pUIYjuqLRrikZ2eV5NHcaFbQ-W5tzE
Message-ID: <CABz7rdCZkzBv-horH0jNLeNuhCNUOaC+Ttkf_-g3CoCaCSfBbg@mail.gmail.com>
Subject: Re: [PATCH 0/2] watchdog: pretimeout: Allow building dump governor as module
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Mayank Rungta via B4 Relay <devnull+mrungta.google.com@kernel.org>, 
	Wim Van Sebroeck <wim@linux-watchdog.org>, Guenter Roeck <linux@roeck-us.net>, 
	Tzung-Bi Shih <tzungbi@kernel.org>, Douglas Anderson <dianders@chromium.org>, linux-kernel@vger.kernel.org, 
	linux-watchdog@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jul 30, 2026 at 3:50=E2=80=AFPM Andrew Morton <akpm@linux-foundatio=
n.org> wrote:
>
> On Thu, 30 Jul 2026 15:00:20 -0700 Mayank Rungta via B4 Relay <devnull+mr=
ungta.google.com@kernel.org> wrote:
>
> > All other watchdog pretimeout governors (noop, panic) can be built as
> > loadable modules. However the "dump" pretimeout governor is restricted
> > to built-in code because it calls trigger_all_cpu_backtrace(), which
> > relies on arch_trigger_cpumask_backtrace(), an arch specific helper tha=
t
> > is not exported to loadable modules.
> >
> > This 2-patch series allows building the dump governor as a module (=3Dm=
):
> > 1) Export cpumask_backtrace() in lib/nmi_backtrace.c.
> > 2) Convert CONFIG_WATCHDOG_PRETIMEOUT_GOV_DUMP from bool to tristate.
>
> LGTM.  Can you please redo against current mainline?  The Kconfig has
> changed.
>

Thanks for the LGTM!

Regarding rebasing onto mainline (origin/master): The "dump"
pretimeout governor was added recently by Tzung-Bi Shih ("watchdog:
pretimeout: Add "dump" pretimeout governor") and is currently in
linux-next, so it hasn't landed in mainline tree yet.

Because of this dependency, I based this series on linux-next so that
patch 2/2 ("Convert dump pretimeout governor to tristate") could apply
cleanly on top of the new governor.

Please let me know what is preferred, or if you'd like me to post
against a different tree!

Thanks,
Mayank
