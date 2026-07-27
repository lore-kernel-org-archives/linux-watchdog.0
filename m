Received: from mail-wr1-f48.google.com (mail-wr1-f48.google.com [209.85.221.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CAA893E7167
	for <linux-watchdog@vger.kernel.org>; Mon, 27 Jul 2026 10:55:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.221.48
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785149722; cv=pass; b=Fz/X40eQ6MXUCqlR7AiYD1L0P2eAHi/5u/3xnQQmU19kWQ0mim6naTxrNMTkz88l99vA6b5O+ATvI6T0GGrJk6G2BhXn4jJ10c7364EtrnX63+sJlNvsrKfP8hW0Gv+keQIKb2STFDgVfOoFOZvn441YkCccUN5x60+HGwPvgZ8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785149722; c=relaxed/simple;
	bh=SJ656KnIzvEN4uJJLAQ9Eml4yAM8DNf1PNFTDvSkOOs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=hKkFn0YL2pP5lmMK6XXxznFMrZEea3eu4cSGwxXVobriBt2FoxWxMmKKq97xKKBW6gd2hj5orQQod4+2MDPuTELCaB5dPLMLyrqiC6kg0VF03ccK2kdAE7NLA5+UGo64lxnkQV2dYtf8F6N/J6wZPIjJtiqbj/owgTL/QQ7jQBY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=iqyrthqo; arc=pass smtp.client-ip=209.85.221.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iqyrthqo"
Received: by mail-wr1-f48.google.com with SMTP id ffacd0b85a97d-47df43bfb07so447830f8f.1
        for <linux-watchdog@vger.kernel.org>; Mon, 27 Jul 2026 03:55:20 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1785149719; cv=none;
        d=google.com; s=arc-20260327;
        b=P8gBuy37da/iG3aH8FjPthlZ89rHosaoxJX6a8rfbVxF3GcRjGKtaCPmj2RmJMAUAv
         8dWGM76bG1jf/PcTWKrJdcW2A7lM+qdrxtOMeknWU7GMElwv9V+1wSlXDSF56eCLbtaN
         lCKygj21NdDVNpfBSWR+bU7cZ6xKiLh8axJ9pzcw/A8QO18fCvnR0iUDDxrjwB74seUp
         2u9KBxgK7wx4b/WUud7qm2NryVOO48RNpZIXQyOHEJIeZ3NpCL3zwGUDEBheczDCwXGM
         SkiJRxzY6VDnKJPZVPrCWpYj+1ywWgjFWmmQY2I0YhgmU6cXwEenYXxIq/3RMUhr/utX
         xh5w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=W3wT6ps9jhP0qGW8Vt+wvXgG5NyLmZhza1+aNvsfiQM=;
        fh=tpguOBLaDLmpW9Pf8yoyjaXlogQgENvC+ZYV4/AaH90=;
        b=lhlgkjLEcGO8k2Dqhxvc3MQyDvlX9cZR4U+NtwaOr5ekhQRohRY5c4OKXAnKnxWoUb
         IvEoSCYucJxq3YB9P5QtY6fFXfr4nGv1mgjFa5g5b8tORfHsxm7lK5D1Ti7BRFsMY33n
         Q8VpbjuRONnz7EOZsf8WbtMdOJYsHu1XqUMqgCNcS9x52vxqcIc9xdWOrpv90l/8lYoG
         T6IHfty1zh87L3uhcR2sgRtzVju80od/FXIi3blVuUTHFCE9VgPhyLyLbnOAOTAASdbc
         erAin44EDOENCm8RjkDZFpVhLxdljHXaCwL6cgDcdTbyK0MzTFnos0eVKGoH0d2LDZbu
         VcmQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785149719; x=1785754519; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=W3wT6ps9jhP0qGW8Vt+wvXgG5NyLmZhza1+aNvsfiQM=;
        b=iqyrthqo8l4jiwK1ICeqWHyisND23UK5PgnggaqWyepS1YrRhRjyxxvCT+6X2E26X8
         Vd5Am6Qgpk0wcKlbz66qv3iVBAizV/jjdHt3nS14LCpfme+rDJUu6RMGf5NdyYNKy8sF
         XRs9CxwxDI8pswbL8dZ3pz1GwNPvmEpkGPyTHIJ1ihr8YcRuSWMPukx5p9bT8RhtwwNV
         3gBvbneXnWRriA38jZt6TuvZ9yslOmhl5wiUDIbCLdw9a4WacVPp32qF8sHKZo27j9vx
         VKpQUUq152QcgruRVhlWYaYz1ifgjlyZ5Lo/tGDY/OwXf4aR8n4GbcJMOdb389aUcUu/
         x4Cw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785149719; x=1785754519;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=W3wT6ps9jhP0qGW8Vt+wvXgG5NyLmZhza1+aNvsfiQM=;
        b=m0NrZWgedmpcZwq9IEGkAupGFolRvHmU+lNoobOBh2aYa5s/fd5GzVHojz+5F5c67e
         RrVTOAvnoH8HZ6uezlNb95UZNRlASLzG5SFOLAO41WwgQpm2XEp6KqsLu0m5R1w1+Wf+
         gtFz8kBDshmXsXTVjUjgUp0T1zlocZew/RJY/27AOKZtryKSlnJ5qgTemMk+GWe9dG9s
         mZNcERYH8ma74QN74j/DPP/dtOt/XKzOcLEWYgqvv6YLSX3fH7ko3VtuVjiUznMkjlHQ
         49HQKjuip6ckWxJ6s2DjLy8MQOpz4QHYTMq0UkIdbKz/AkI7+pfDtUxgTfMhgcgT2FQK
         S70w==
X-Forwarded-Encrypted: i=1; AHgh+RpLwv3Go06Z6d9F/LsSMLOLb1wUJbl5emFg2z5KexLaMzf1XG8xI6c4EZe4s/HjODjdLrUdIjyRsaVzr6eshA==@vger.kernel.org
X-Gm-Message-State: AOJu0Yx+fQHB5X/1nk025Oioo5xXIyAbBgFhbdF4ZWd465NsQno3PwZq
	4YQ4z2SyL3Z8Fh2QeBO6MbwarhKhJzGlLQHZ/mviKW/arNLwdyRCW+cdbrVQPzY7vGNsSp3bFpx
	gfzZ7kXvJaU48gQVdVr/kAeUZPJZMsRA=
X-Gm-Gg: AR+sD12TqF5IimJGIZI42dZ225IaxMWDGD6/3V58oi0QQG7oD/cYtBDiUorALm/T7c6
	2ikK+ve83WvcubDhxStrV5rk+F1oJF4LP4512zeobmD9N+JTkeUT7l1luWXIwxxekoT2ZrnP+zy
	FNZP7ofYF45Tb+lRdnNXW/MQwFTP76mFCJ4qvQg9sdydgpFkv9P2GkWYcnDhk3GCkCaGDGqF52o
	cfsvtMWE1e0fYNQczqowPLFJYPXBo4nclyXkoLOQs+uKRxx+4x0NXlO7iIfLITGxmLspjjM8z0e
	3KKIHKxBT7m6wfbzIKRIv3rk3fAP0rlhL2w5a0HfWRwPuugxTswpeQzP3HdmR6ZePzEdosCCofo
	OMckb
X-Received: by 2002:a05:6000:2c09:b0:47f:923c:9d92 with SMTP id
 ffacd0b85a97d-47fae7aabdamr114692f8f.51.1785149719033; Mon, 27 Jul 2026
 03:55:19 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-watchdog@vger.kernel.org
List-Id: <linux-watchdog.vger.kernel.org>
List-Subscribe: <mailto:linux-watchdog+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-watchdog+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260715133922.2129340-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
 <20260715133922.2129340-2-prabhakar.mahadev-lad.rj@bp.renesas.com> <0eb41a71-a013-4686-bd9a-4f4df5acaa3a@roeck-us.net>
In-Reply-To: <0eb41a71-a013-4686-bd9a-4f4df5acaa3a@roeck-us.net>
From: "Lad, Prabhakar" <prabhakar.csengg@gmail.com>
Date: Mon, 27 Jul 2026 11:54:52 +0100
X-Gm-Features: AUfX_mw_UjDRNyZht9hoN_J_DKFxeJtt1sRoyca3DWTwQqRK4wCwyzKemt9mUKY
Message-ID: <CA+V-a8v_FXNp-jvkM3X0sEt3-Gt7zm9kq3cJ7hn48Dnod+O9BQ@mail.gmail.com>
Subject: Re: [PATCH v2 1/2] watchdog: rzv2h: Convert WDTDCR handling to regmap
To: Guenter Roeck <linux@roeck-us.net>
Cc: Wim Van Sebroeck <wim@linux-watchdog.org>, Philipp Zabel <p.zabel@pengutronix.de>, 
	Geert Uytterhoeven <geert+renesas@glider.be>, linux-watchdog@vger.kernel.org, 
	linux-renesas-soc@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Prabhakar <prabhakar.csengg+renesas@gmail.com>, Biju Das <biju.das.jz@bp.renesas.com>, 
	Fabrizio Castro <fabrizio.castro.jz@renesas.com>, 
	Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Guenter,

Thank you for the review.

On Mon, Jul 20, 2026 at 3:56=E2=80=AFPM Guenter Roeck <linux@roeck-us.net> =
wrote:
>
> On Wed, Jul 15, 2026 at 02:39:21PM +0100, Prabhakar wrote:
> > From: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
> >
> > Convert the WDTDCR register access from raw readl/writel variants over =
to
> > the regmap framework using devm_regmap_init_mmio().
> >
> > This conversion serves as a preparatory refactoring step. It allows the
> > driver to subsequently support syscon-based system controllers natively
> > by passing along alternative regmap handles without forcing messy
> > architectural branching at runtime.
> >
>
> This patch does a bit more than just converting the driver to use regmap.
> It also modifies both reset control handling and runtime pm handling in
> the start, stop, and restart function error handlers. Those changes need
> to be implemented in separate patches and explained. When doing that,
Previously the rzt2h_wdt_wdtdcr_count_stop/rzt2h_wdt_wdtdcr_count_start
didnt return value, with regmap support they do return value. So now
we are just reverting things back in error paths by putting the
resets/pm to their original state.  Please let me know if you still
prefer to split it up.

> please address Sashiko's feedback or explain why the issues it reported
> are of no concern.
>
Ok.

Cheers,
Prabhakar
