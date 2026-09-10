Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B6316313540;
	Thu, 10 Sep 2026 05:14:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789017241; cv=none; b=PePlYW5rZnqX4pYJ80BxZGO1cZ8Exs2jyiz0IiRl+6rP0kLaQaYi7SJimDZKZbQp1JmYPe93QYco+z/bNLRNr5U9MKuAx67sUJGcW5k1lCum1c+0pZiUJKAhwkWYzx4okrepCzTSHVZBotysEKCT3K9d6Ng5WUAxJck+yRl9NIw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789017241; c=relaxed/simple;
	bh=csOB3KFHrL5IP5jWuNQqSs4TZxHojxhoTBc2tdw9x0c=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=E9CuYbsXoAgccvXjHS+KpGnsnSU9g9MPDcY2EEuW+ATRP3mwK/ybIdSVm80dPOUN5vr0QQOL/JGJhWtJqFJYwfSAu3uOtGys3dEtbjLcSJZekMrUwrxJ+PC31Ghf/jKybs/vEjRX4wM26zsXlwmbs2JGltqF+iVvGs5hXgP/BLw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ETnA3ISv; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ETnA3ISv"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D3E4A1F000FF;
	Thu, 10 Sep 2026 05:13:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789017240;
	bh=csOB3KFHrL5IP5jWuNQqSs4TZxHojxhoTBc2tdw9x0c=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=ETnA3ISviF46I8jJDuGnmpUp6DPX9e19bIe8i833iH83v+g87sqs84yFTiRIDyTHg
	 A7eV3NJoV5bf5+r3qEioLtGLdHms6rflaM0R0QN7vxq8Tzxd78PpNK25dM5I+X8CZq
	 MP4yEuWuSk0pcO3ab42b35fpQ8E76uNI8IlnTYJ8OZK8w03Im/EdZjNogHH48JMORD
	 xVHomvqh4L8M1tKtmRcDJuYZ508m2ed00wgbmxQApHCSi8qmGEKACGXl94Av5wbpRZ
	 qGg5b9+VzJPZ4bHrcFa2WEmzdV6PBcw+4OUdfl5k4Jgy/WydgIIbCjpVFshf9/qT/l
	 vKoEq4iKE2low==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v5 1/5] dt-bindings: rtc: nxp,pcf85363: add timestamp
 mode config
Reply-To: sashiko-reviews@lists.linux.dev
To: "Lakshay Piplani" <lakshay.piplani@nxp.com>
Cc: conor+dt@kernel.org, robh@kernel.org, linux-watchdog@vger.kernel.org, linux-rtc@vger.kernel.org, "Alexandre
 Belloni" <alexandre.belloni@bootlin.com>, devicetree@vger.kernel.org
In-Reply-To: <20260910050747.1901440-1-lakshay.piplani@nxp.com>
References: <20260910050747.1901440-1-lakshay.piplani@nxp.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 10 Sep 2026 05:13:59 +0000
Message-Id: <20260910051359.D3E4A1F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-watchdog@vger.kernel.org
List-Id: <linux-watchdog.vger.kernel.org>
List-Subscribe: <mailto:linux-watchdog+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-watchdog+unsubscribe@vger.kernel.org>

> NXP PCF85263/PCF85363 provides three timestamp registers (TSR1-TSR3)
> which latch the current time when a selected event occurs. Add a
> vendor specific property, nxp,timestamp-mode, to select the event
> source for each register.
>=20
> Also introduce a new header 'pcf85363-tsr.h' to expose
> macros for timestamp mode fields, improving readability
> of device tree file.
>=20
> Signed-off-by: Lakshay Piplani <lakshay.piplani@nxp.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260910050747.1901=
440-1-lakshay.piplani@nxp.com?part=3D1

