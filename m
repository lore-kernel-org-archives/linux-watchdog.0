Received: from mail-ej1-f49.google.com (mail-ej1-f49.google.com [209.85.218.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 865C83A9D8F
	for <linux-watchdog@vger.kernel.org>; Thu, 27 Aug 2026 11:57:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.218.49
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787831866; cv=pass; b=MGkz9oevsI1zwzdrmUWaFiIXkZZFxOyrq+t5EjWapFQmo/vWb5GhQIK00H2kIybt3qu5opFxOGqlyLGvDcBX/DYZzdJaz0yJpLWLAvCr4HHCYNVyUYFDxHNzKLDs6UP/kThgvzCHGBIJaFq8xAVr3eTIhdN2NNq1XzFa0tvPDKw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787831866; c=relaxed/simple;
	bh=6WdDC4sV3epSU/xCoz/N1VgwbDwuBbVuoylTs5Qjj+4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=JBhvDJg2bHp/W3l7S4OxZvpiBumjtoXUEQwmKa4ElzeK2KHCvi7AQCf33t/i/Isefxs/w3jMRyzW6dgEw91GHmMYvIMt4WeYA7r7aHmm4LEfqQdU9MZWUZdpzkX34aDmBjVbXj2tzUQNPTFEI6WBMs6I5x+o/H1C6XTokcwRmO4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Bw22IXTw; arc=pass smtp.client-ip=209.85.218.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Bw22IXTw"
Received: by mail-ej1-f49.google.com with SMTP id a640c23a62f3a-c1600d040e4so142147166b.1
        for <linux-watchdog@vger.kernel.org>; Thu, 27 Aug 2026 04:57:45 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1787831864; cv=none;
        d=google.com; s=arc-20260327;
        b=O0rMN5TLS5tyz7lm29/wUGgezEuNcm4dSMKdKg9v50Pp1KeNGJdJM9lJPD1ckVIVrc
         xcDQwc8wi+I+ssRFQznGVSyC4a8nPgXub3lteyK50M3f5wiJAbJpshlL5U+IvkLNi06g
         muGn9g8hN3ZOUz1N7Zk/a2GXRHj3ej9x6XiTq464CTg4D5QmoonnezamkLQFaQQnW6Ih
         TaAtpjSSE6JW1hcjaP1+4UXd+/rlWi0FKuu9Roneb8fSdPKRxzmIB5FSMkpVoc9DdAZr
         H7rSoXLRjBayKwQ4Ct+RLiJeVIYGxPC/pfHovjcQ/i0lcj1ldpvcE27z8FXam9ry7w/2
         FgVA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=6WdDC4sV3epSU/xCoz/N1VgwbDwuBbVuoylTs5Qjj+4=;
        fh=ZwQnRugb6KxCcFwvtvmj7ltWtcW4Dpekf0r9W1bth3A=;
        b=BxIAC3acR/kt7e8tlruYwkpPhfcoNteCHqyz+LQHgeFQCXXU86TlzC/AgqWtDXjd/P
         Afs6a2rta9enwK5M/qRu71TbPSBlxTgL2MYCttVXZkMcAIyyqskjd4q2XXd3s8NwgIcz
         tI5j09SWK6crayrzpdSMoxdwSBvKwKTQRQntO29idFBTO/gub7Zbu9Tf66wwel3VvUFC
         gephol6+UcBYbhSGopgMxtJmqg1Bjj8ZEFt3UbtWqjJup4QFXYm+iA7qhGkXSaarhrEw
         3d9nMM9CHEy52UuZ6SO7H0zIXR5aesoZdur8HYWByFUUsILrwPfJohgP8T3rjYZuwKV4
         iNtg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787831864; x=1788436664; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=6WdDC4sV3epSU/xCoz/N1VgwbDwuBbVuoylTs5Qjj+4=;
        b=Bw22IXTwgHN75sAceHvrr7MFp/nbbM+A92yH9eFDnMLzb1DvBiaNYIWBWyfjtvm2Ul
         jqhky/f7Djmfld0kEnHwztrBMs+x2vW12DXwliNr8MSRF8/pMSnaLjCE4+W0Hahd7wm9
         4yR9ksktbwqUgvJeBOtT3RjX592+rc6SY/IZjm9tKHJiwyjQs5E5xXiJiG/2rz/I9aEQ
         76T10yeSK9LHsTgO8FE5+v0RdKBwE+JISB6qG4b9ZwA04mkTdZGxgvJaFCBlICPoLKjb
         GG+KH0d9lXUWlpShVFMgtwhN7ZvX/0oAsUHN0/4SneV4aVod5VweF43LzTZxMxxFx4Hy
         XkxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787831864; x=1788436664;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=6WdDC4sV3epSU/xCoz/N1VgwbDwuBbVuoylTs5Qjj+4=;
        b=jI/vYrttb/aeuUMqVw9LnYIctR/asAUIsHQrDHrLvKHsBJjRvvBwYcM+1lWGuWoR9P
         64B7CAthmief8s7NqUsjdF0cdQ3YcjdU4D7Lq8kK0N0PsjjzoN9+GowxNTYGy8+XGI15
         hfI/VLfdJFtIsLYOlYlrJV7ORAsLcDuifTR0T8Pq+DWOm0w/eJgF4ThjCnfJREYjUuOE
         4fnW1rDd1TicBW3I4FJwwW6NLy+kinSlJSSmtphdFdyeyCuRoM/aHwHUFyqerUONMm14
         2ZZ+ZgGmUXVbsvlgHR+ufPLORhkky4PVb2d3QKH2BpkgI1BVNeAAn4xMbKU4+zX4a6qo
         SOqQ==
X-Forwarded-Encrypted: i=1; AHgh+RoMBrDY5d2dzsSPIZR4kj3m1azzncWkRXFjEfoJ3iae7KaC6yuS3jA1dyULDtTSygjvpiAIcCU46i4Wktfvyw==@vger.kernel.org
X-Gm-Message-State: AFuF++mYq7uRMwVpWe5CnCCxD6YB/ZX5VVcH0BRIfCbhDi4QqeZHQpvr
	Xey1XBSDjPnpLxMEqpTVYTzvMa3pXNAPgXpODGPOhZ5XBTpvXze3J0phSjl72z2krVQqUZeAV7F
	ofT0BTn4VFFgWBztRhSf3kQ/yJgRKnzU=
X-Gm-Gg: AR+sD13BlBG7elrvLv+N46YeT4swnKwOkTMSTlAmHaosSQdEDWXdCNUlGhRC3G2Qx/I
	n+OLmRndX7yeGbvaeOMO7vJinhzoBNh2M2vWBY9UQZ58ZqEH3u56czN0dNWyslCEaq5vg74g8eW
	jMlLAKzkyEgRGVnqFbiOQEWBcdDmrQ/m72ZJaE3VHSXr3OS2Z8rp9vE/vm9L7XN1P+prcfWyThz
	0M1dhJccPbOYx3tGxT+1rPTMBWrBauPEvDTmJxRdZ/n2blwj/BYqa3uHNGtbmL8Gh9YHvqARGmA
	Wr8h152nm9bhqvBMI1wB5/iAeZEKzxgxJm5rVkE5pfk=
X-Received: by 2002:a17:906:4784:b0:c1c:49d9:4c34 with SMTP id
 a640c23a62f3a-c25360ae6f6mr459116966b.11.1787831863644; Thu, 27 Aug 2026
 04:57:43 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-watchdog@vger.kernel.org
List-Id: <linux-watchdog.vger.kernel.org>
List-Subscribe: <mailto:linux-watchdog+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-watchdog+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260809160643.33991-1-l.scorcia@gmail.com> <20260809160643.33991-2-l.scorcia@gmail.com>
 <20260811-amethyst-seriema-of-gallantry-ca9c7f@quoll> <CAORyz2KXJf4gU46649w1ncb7TAOErdoGmfOMzwKr8b+eGdAgVA@mail.gmail.com>
 <20260812-smooth-artichoke-kittiwake-f6e85e@quoll> <409e398b-eb8f-48eb-a0d3-ed8fa811328f@kernel.org>
In-Reply-To: <409e398b-eb8f-48eb-a0d3-ed8fa811328f@kernel.org>
From: Luca Leonardo Scorcia <l.scorcia@gmail.com>
Date: Thu, 27 Aug 2026 13:57:32 +0200
X-Gm-Features: AcwNN1X9AttqB8t1bj6TQbgbNwwMvZ74IM7YuKbj9WRorR3Nx4t8S9M-g6F42ms
Message-ID: <CAORyz2JbOsiDYzCw--Y-tiRXEaZ69B8S9Hjvs-j5WZmtck-ynQ@mail.gmail.com>
Subject: Re: [PATCH v3 1/8] dt-bindings: reset: Add mt6589 toprgu reset IDs
To: Krzysztof Kozlowski <krzk@kernel.org>
Cc: linux-mediatek@lists.infradead.org, 
	Wim Van Sebroeck <wim@linux-watchdog.org>, Guenter Roeck <linux@roeck-us.net>, 
	Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Matthias Brugger <matthias.bgg@gmail.com>, 
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, 
	Philipp Zabel <p.zabel@pengutronix.de>, linux-watchdog@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"

> > Then these bits stay as is in DTS but bindings header is not needed. You
> > can have of course DTS header, as we did in the past multiple times for
> > such hardware constants.
>
> So I wrote above this to myself and can be ignored completely? Then why
> would we not ignore your patches?

I am sorry, I'm definitely not ignoring reviews and I'm actually
trying to understand and fix my mistakes.
This reply refers to v3, but in v4 you reviewed earlier today I added
reset table support in the driver, therefore in v4 those constants are
IDs instead of bits (and it should help cleanup the other MediaTek
existing bindings if deemed necessary).
If they're IDs that describe actual hardware capabilities, shouldn't
they be located under devicetree/? (Again, I understood my mistake in
v3, but in v4 it should be fixed).

I feel like I am missing something that's very clear to experienced
kernel devs about the boundary between kernel sources and device
trees, but I can't seem to figure out what exactly. I'll try reading
the kernel docs again.

Thank you for your time and patience.
--
Luca Leonardo Scorcia
l.scorcia@gmail.com
