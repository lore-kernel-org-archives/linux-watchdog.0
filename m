Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792496112;
	b=0/wWebfV1JfN9CQcXlm7S516eOzP28+6TDZ/7Qf7tyRzZPgna8Seim0L8ee4vNCrdHtu
	 kEzAJnAQlTFvxz6GsW/hQIa5GEEokCWEaGWN9HFQYkGR9x29XqIVCElZK4LY+9cB4rIXs
	 kclNNXNnUpPSmdTb2K0fZ+XvUEO+cCaMH7Ji8B+kCyRnzgwO7iP627+x+gyEQi1H9QJ2h
	 qHizVQ7ciFwyyvhCenHk3yd6dXG/peqFZ4zFsueDPtRFGkxayZ9M6SR8JjG17x0tjKqtY
	 aCzmL65Kd9PsHkxWB9qDDeXTW/mDCS5LQ5tl6mKeelYIdcjCvvhIgfuT410pYJ+OsiQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792496112;
	h=Received:DKIM-Signature:From:To:Cc:In-Reply-To:References:Subject:
	 Message-Id:Date:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 X-Mailer;
	bh=KC+tsMxL27T8X/Np0Fb1tWZeOW8IxFTBoi/UezmyYRg=;
	b=OHcngJGkUjuDBwkdbpsotMKVLWsg5sGux3iuDopAJVCLRq6fYvb2klDHlwcKzt6kiRbE
	 Wz3c6Ws9l5a/aay9qjSRsje7mVyi85uH0mD1nJjvgCtTimOWPF4pCsRO/ejHXfcFYvzli
	 2x5pS2mGvmmXDJUEyt6A1AZUTUg6xtHlSrfg/U0YbuRf9+8xpukd65R1pV7Wy+aJ06iXl
	 RcrsaJH+bMfLO5NJh99guu4VVcbDvELtLLeA69hadVbFooE2ciS6k7e+L2WGNbknA50t5
	 X4s8uFL32aFqaTbh7kLM4T6HWR+FGYaI5H4bsrSB6Yi2BYAVmR3ohyUQDzKTJzFQy4w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=UYwCaJ0R;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 18F3E606A331;
	Tue, 20 Oct 2026 11:35:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=UYwCaJ0R
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2707E1F000C4;
	Tue, 20 Oct 2026 11:35:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792496111;
	bh=KC+tsMxL27T8X/Np0Fb1tWZeOW8IxFTBoi/UezmyYRg=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date;
	b=UYwCaJ0ROq/utWY4xpPuooyxMbQRo0ykWMVu9P2d28ECMV1HhSYPgVJj/ocpbyhNn
	 BU9cWCF8bsTbVQwhv4e/XXWCNjtjgiv1XGb5O4xwR8szS65CDhXevP24Pa6+W8KrC4
	 GvsLZbXEVOuQYl5+5ALmkweqkbt7xd6Pv1Kh0ZXPzNltbAIUZ0+f3acAhEFtW8/bnr
	 /Y4GYmMjF33eUML1zli1IoUMnSmeg1jeu7m/1yMd0xIs5pHtHEvQqAycCYx2liVywR
	 1zrFbzK+sd+BFjhpht6JMXRomiOuwi6m6gGqM0Z57+HQ4DwQYW6Qh8RWkvlzvikg9T
	 ES7n+e/Ea+cJg==
From: Lee Jones <lee@kernel.org>
To: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Frank Li <Frank.Li@nxp.com>, 
 Sascha Hauer <s.hauer@pengutronix.de>, 
 Pengutronix Kernel Team <kernel@pengutronix.de>, 
 Fabio Estevam <festevam@gmail.com>, 
 Support Opensource <support.opensource@diasemi.com>, 
 Lee Jones <lee@kernel.org>, Wim Van Sebroeck <wim@linux-watchdog.org>, 
 Guenter Roeck <linux@roeck-us.net>, Primoz Fiser <primoz.fiser@norik.com>
Cc: devicetree@vger.kernel.org, imx@lists.linux.dev, 
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
 mfd@lists.linux.dev, linux-watchdog@vger.kernel.org, 
 upstream@lists.phytec.de, andrej.picej@norik.com
In-Reply-To: <20260924065044.368341-1-primoz.fiser@norik.com>
References: <20260924065044.368341-1-primoz.fiser@norik.com>
Subject: Re: (subset) [PATCH v2 0/4] da9062/da9061 watchdog timeout mode
Message-Id: <179249610684.1885397.15733265210505859748.b4-ty@b4>
Date: Tue, 20 Oct 2026 12:35:06 +0100
X-Mailing-List: linux-watchdog@vger.kernel.org
List-Id: <linux-watchdog.vger.kernel.org>
List-Post: <mailto:linux-watchdog@vger.kernel.org>
List-Help: <mailto:linux-watchdog+help@vger.kernel.org>
List-Subscribe: <mailto:linux-watchdog+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-watchdog+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-watchdog+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Mailer: b4 0.16-dev-ad80c

On Thu, 24 Sep 2026 08:50:40 +0200, Primoz Fiser wrote:
> This is a revival of a series originally posted by Andrej Picej in
> December 2021 [1]. It lets the DA9061/2 PMIC watchdog be configured via
> the "dlg,wdt-sd" DT property, to trigger a full SHUTDOWN instead of the
> default POWERDOWN on watchdog timeout, and enables that on the PHYTEC
> phyCORE-i.MX6 SOM.
> 
> From v5 of original series this resend drops patch 4/5 ("dt-bindings:
> watchdog: da9062: add watchdog timeout mode") because it already landed
> upstream as commit 382256b219fb, later converted from .txt to YAML by
> bd888a4377ae. Thus dlg,da9062-watchdog.yaml already documents dlg,wdt-sd
> property.
> 
> [...]

Applied, thanks!

[1/4] mfd: da9062: Make register CONFIG_I writable
      commit: db52dc6f9aef97ad7f9738b5f595f42299946793
[2/4] mfd: da9061: Make register CONFIG_I writable
      commit: 630751941b7488912fbe432c2412b8c9fbfaed9e

--
Lee Jones [李琼斯]

