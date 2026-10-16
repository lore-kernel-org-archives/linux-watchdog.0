Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0154146D2A9
	for <linux-watchdog@vger.kernel.org>; Fri, 16 Oct 2026 13:24:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792157060; cv=none; b=CR2ZHWrHU47HzSq4TC2aFknszhjrBBiENA02/yPsWGpBIYMnimHoOi92zqM1N5h27I3AWn/7xYViSfKfknxDg5UQ8fPL4DY3HxhKmTNmxO7eBakRKH/fnsFasbAZmKeg46gVNz3VywcIKlAmnblyz4/gCUyvDR5l6zriB488bVg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792157060; c=relaxed/simple;
	bh=tptGbnUMiBCsaJa3McpSM7cvw+fPwwT/+mAijjESQgw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=bg+bFS/fEFXMuOMThYBqlFI67dZtLfyGKKMFHrr9mUzsdbU2b4jDjLJfrgecl5DA6JZ6vajzgtagSwZnIozi3tVW1Rn2W2/0XhAOSaLQVqA3zn9RBPtCjoa8NR3X4adjocrO0bH54ihegagPDWIzi8idIzHDeiZp6r9dlPdkg18=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VhVS1sBb; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VhVS1sBb"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B473C1F000C9
	for <linux-watchdog@vger.kernel.org>; Fri, 16 Oct 2026 13:24:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792157057;
	bh=tptGbnUMiBCsaJa3McpSM7cvw+fPwwT/+mAijjESQgw=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc;
	b=VhVS1sBbaKLkdcvLt5i6gurhbGPS6GnTaL9afj14kDG2UyKbacO4DdRHG3unPm1z/
	 EesiWEHhYiN7gJQo+wJxPOQw7wvbbd35FHkMYzoFAjmul/CgdZa7oHBmt9hBs3bEZl
	 KOzAFdXS4JaGkCLnNIkil7kTOffV47s1XYtBl3kAOiuEux+AUF1hlIKG5sH6lyuCGP
	 zhobrqKDM9G/CWliZVlCRhzq7E2eHE1IzfX+CpzBY9qtHcQdyY8KKeEd+w5njxPj32
	 Gzbmf2VfVG8F3r+9eXSeruqbFG/aaFOo8ax+CERORR6yaMLOtsEn1Fy9uuPfHI/Vfj
	 i8ld0EEUl51GQ==
Received: by mail-lj1-f179.google.com with SMTP id 38308e7fff4ca-3a5a26c8412so59680511fa.3
        for <linux-watchdog@vger.kernel.org>; Fri, 16 Oct 2026 06:24:17 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AKwUvBzszsPIVz+yXiM6roa61Omc1RvzcsNFjDxitk+1FuQgCjRP2PG8znS5KVT+lemxVIO8HF7SnQKFWV0oDxWvpA==@vger.kernel.org
X-Gm-Message-State: AFq9FYKPq1QI/XyE/R+5dZIUwNWIOXHNYZ0u7ooF8FKafLFAq8AcYRxN
	L88sLEfhCDxgPK35TeyjtLvINKBkboQcHWrQ1ZjJlBltWScC7I3WfztjpVOr8PSUVR7QEy4U3Tm
	2Qzxsu+UxD+dtoQWfFGtHWMf4bpJRb9s=
X-Received: by 2002:a05:651c:2212:b0:3a9:d70c:f75e with SMTP id
 38308e7fff4ca-3a9d70cf9femr44778141fa.7.1792157056449; Fri, 16 Oct 2026
 06:24:16 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-watchdog@vger.kernel.org
List-Id: <linux-watchdog.vger.kernel.org>
List-Subscribe: <mailto:linux-watchdog+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-watchdog+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20261014-apple-m4-pro-max-initial-devicetrees-v2-0-961edd8d661b@cyberchaos.dev>
 <20261014-apple-m4-pro-max-initial-devicetrees-v2-7-961edd8d661b@cyberchaos.dev>
In-Reply-To: <20261014-apple-m4-pro-max-initial-devicetrees-v2-7-961edd8d661b@cyberchaos.dev>
From: Linus Walleij <linusw@kernel.org>
Date: Fri, 16 Oct 2026 15:24:04 +0200
X-Gmail-Original-Message-ID: <CAD++jLn6dKK+1WSash3t0ha8Av9zJENjY0voXD5kRqOqm+3fHA@mail.gmail.com>
X-Gm-Features: AclHuK9pL3EIJMMfpSpFM0KiMYOGh8ROn5xZqcFmx2VF7M6wTBgCRfX7l979pQc
Message-ID: <CAD++jLn6dKK+1WSash3t0ha8Av9zJENjY0voXD5kRqOqm+3fHA@mail.gmail.com>
Subject: Re: [PATCH v2 07/10] dt-bindings: pinctrl: apple,pinctrl: Add t6041 compatible
To: Yureka Lilian <yureka@cyberchaos.dev>
Cc: Sven Peter <sven@kernel.org>, Janne Grunau <j@jannau.net>, Neal Gompa <neal@gompa.dev>, 
	Wim Van Sebroeck <wim@linux-watchdog.org>, Guenter Roeck <linux@roeck-us.net>, 
	Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Thomas Gleixner <tglx@kernel.org>, Radu Rendec <radu@rendec.net>, 
	Lorenzo Pieralisi <lpieralisi@kernel.org>, Hector Martin <marcan@marcan.st>, 
	=?UTF-8?Q?Uwe_Kleine=2DK=C3=B6nig?= <ukleinek@kernel.org>, 
	Sasha Finkelstein <k@chaosmail.tech>, Mark Kettenis <kettenis@openbsd.org>, 
	Andi Shyti <andi.shyti@kernel.org>, asahi@lists.linux.dev, 
	linux-arm-kernel@lists.infradead.org, linux-watchdog@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-pwm@vger.kernel.org, linux-gpio@vger.kernel.org, 
	linux-i2c@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Oct 14, 2026 at 8:56=E2=80=AFAM Yureka Lilian <yureka@cyberchaos.de=
v> wrote:

> The pin controller on the Apple Silicon T604x (M4 Pro/Max) SoCs is
> compatible with t8103. Add "apple,t6041-pinctrl" as SoC specific
> compatible under "apple,t8103-pinctrl".
>
> Signed-off-by: Yureka Lilian <yureka@cyberchaos.dev>

Reviewed-by: Linus Walleij <linusw@kernel.org>

Yours,
Linus Walleij
