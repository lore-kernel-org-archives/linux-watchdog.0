Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C58A1382F0C;
	Thu, 26 Mar 2026 12:03:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774526618; cv=none; b=uQaXNBR5+whrRMtfD22797aaBF5Vj7uydKrUKxhApW2X5+AIOmtCVD14P/PDQQfhvsHiHEc1u80S66wc5N93tp07/HXe1hpwzsxTpVUdyn32evoStbGUhHQHifE08Ku8W9jUSYXILH0ygqffZmUrLCe/67odU4He+VfhKyUBfn8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774526618; c=relaxed/simple;
	bh=nXhBTq4rlMGq3oWCWKDipgnde+DqeqIFykqfsBS8++M=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=gsxKLcEjn3mYLwgMmwb23uF/fDzRZSoDMSk5/QV0YXPPZySBEcJ+MhMXpwPQyKrLX7EgbbHDsSE0H+U1Y0pp1THNshNyU6/Id4Q0DrlTYuYgzs3sDSocHmSiaJlfUu5jtw92pcrAV0ak6D1SHCRS7KXpQqB8riGga9YYL7CXb2g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FSgCAk+Q; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FSgCAk+Q"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2684DC116C6;
	Thu, 26 Mar 2026 12:03:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1774526618;
	bh=nXhBTq4rlMGq3oWCWKDipgnde+DqeqIFykqfsBS8++M=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=FSgCAk+QgxiULXZwRGkDHP/fy1R47SgqrJ3PstxUiF+M415/SNMLm649aFGuJQ3/2
	 jCXJT4qtG+0DoAfEFASVDyDQY34+eDl588ia0DRor4y/vPpo2nPmIayr59PMDkeMJY
	 Z4YEzHlaOqXQ6kOKZwM+4zoiQF40FUd+66rVNlwNHRdwUV3GscWJPf6XddN/mhrr1y
	 gpvs/1rOWpOkw4lcAe2nZ5Cy02liIcEUQ9uvb6bQRTjQbUMgl+k7Chc2Y6HLhpIu9F
	 yYfVmGJezaLAstBVGCJwpRz5XTsMO/8BKIjTyumvhKNC3oYpaOS5JxdAaDs90IQeZ+
	 LBsnsa2GppHiA==
From: Lee Jones <lee@kernel.org>
To: Catalin Marinas <catalin.marinas@arm.com>, 
 Will Deacon <will@kernel.org>, Andrew Lunn <andrew@lunn.ch>, 
 Heiner Kallweit <hkallweit1@gmail.com>, 
 Russell King <linux@armlinux.org.uk>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Linus Walleij <linusw@kernel.org>, Lee Jones <lee@kernel.org>, 
 Pavel Machek <pavel@kernel.org>, Wim Van Sebroeck <wim@linux-watchdog.org>, 
 Guenter Roeck <linux@roeck-us.net>, 
 Mauro Carvalho Chehab <mchehab@kernel.org>, 
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 Sebastian Reichel <sre@kernel.org>, 
 Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
Cc: brgl@kernel.org, linux-arm-kernel@lists.infradead.org, 
 linux-kernel@vger.kernel.org, netdev@vger.kernel.org, 
 linux-gpio@vger.kernel.org, linux-leds@vger.kernel.org, 
 linux-watchdog@vger.kernel.org, linux-media@vger.kernel.org, 
 linux-staging@lists.linux.dev, linux-pm@vger.kernel.org
In-Reply-To: <20260316-gpio-of-kconfig-v2-4-de2f4b00a0e4@oss.qualcomm.com>
References: <20260316-gpio-of-kconfig-v2-4-de2f4b00a0e4@oss.qualcomm.com>
Subject: Re: (subset) [PATCH v2 4/9] leds: Kconfig: drop unneeded
 dependency on OF_GPIO
Message-Id: <177452661287.1970463.2525511615617194577.b4-ty@b4>
Date: Thu, 26 Mar 2026 12:03:32 +0000
Precedence: bulk
X-Mailing-List: linux-watchdog@vger.kernel.org
List-Id: <linux-watchdog.vger.kernel.org>
List-Subscribe: <mailto:linux-watchdog+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-watchdog+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Mailer: b4 0.16-dev-ad80c

On Mon, 16 Mar 2026 10:45:24 +0100, Bartosz Golaszewski wrote:
> OF_GPIO is selected automatically on all OF systems. Any symbols it
> controls also provide stubs so there's really no reason to select it
> explicitly.

Applied, thanks!

[4/9] leds: Kconfig: drop unneeded dependency on OF_GPIO
      commit: b727ba2560a8a806680b45c9acc5a49bc39b8e43

--
Lee Jones [李琼斯]

