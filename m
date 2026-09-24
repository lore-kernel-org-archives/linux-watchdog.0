Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C23EF49CF4A;
	Thu, 24 Sep 2026 15:19:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790263186; cv=none; b=JdWNmU0+VO0f+K5QXgfLNZvVC1AftNF6gH56xKQAxX2N7/O1B/baYG1F9Uc6ZvPJ6s6IkUnSn5dzFn3AM2u+V+zpNmH15Q/vrP08NHxx3hMHu93dkuBP3UkmBs1/cWTgIOqn6VZVPt4ECzqz0V87BRaqPI8Fbfp4Icd3DQXpDn4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790263186; c=relaxed/simple;
	bh=pyh3E0T7wHWZ5xF30RuHqbWp7HdVsJURqrjlTjJ7j6s=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FTud6diUgibfs3DPxQ4GrfrHhLFlu00rJzxfafft2kZPiXbhPMS9/jIVshysNYblfaADXryTocXxt1Rs568t1QgtbMsTP2j3rITGCJx7MneiAEY9oyK399LZIkKPmsSKna76KDwe75Go2eU3kCt7p2+IpR3K/+aNhspqXbcp0zs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZZLddXuV; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZZLddXuV"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 532041F000FF;
	Thu, 24 Sep 2026 15:19:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790263185;
	bh=gebdkbijRtHzszj2kDNgo747gKRQdLMacTd+zFkUt7s=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=ZZLddXuVjCC1Pf2eZgdcxl8V1oBtP1NX87KTV/jCIiOwg11CznB5KQh+bbTRxwi2O
	 ALFMXttah8Z9a8jQE637X/DmUjFAWanrheN+H+iVYqCQZGs4K2hrlL/RpqI3zUAgi0
	 tO7YZEHRQ7ml44bgFDB91c6JdlUPOxBLRL7XcakFBRxcZbulyMwtF1FNTaN58/HgGz
	 MviDFPwDE26chFYFaIUPblgxKGtFMz1y/m0Tyq+sd+xMWPB/w/QuY79NY08biZZLsv
	 acSGxWDMAmjkBchcL0eQAM4f82XmTWM3y6zUJXeo6AFnzAhCHtauB9VlqTO8lg2tIi
	 iSNcQUO0IbuIA==
Date: Thu, 24 Sep 2026 10:19:43 -0500
From: "Rob Herring (Arm)" <robh@kernel.org>
To: Faruque Ansari <faruque.ansari@oss.qualcomm.com>
Cc: Andrew Morton <akpm@linux-foundation.org>,
	Benson Leung <bleung@chromium.org>, Mark Brown <broonie@kernel.org>,
	linux-arm-msm@vger.kernel.org,
	Oleksij Rempel <o.rempel@pengutronix.de>,
	=?iso-8859-1?Q?S=F8ren?= Andersen <san@skov.dk>,
	linux-pm@vger.kernel.org, Sebastian Reichel <sre@kernel.org>,
	Guenter Roeck <linux@roeck-us.net>,
	Guenter Roeck <groeck@chromium.org>,
	Zhang Rui <rui.zhang@intel.com>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	Lukasz Luba <lukasz.luba@arm.com>,
	Daniel Lezcano <daniel.lezcano@kernel.org>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Matti Vaittinen <mazziesaccount@gmail.com>,
	Tzung-Bi Shih <tzungbi@kernel.org>,
	Ahmad Fatoum <a.fatoum@pengutronix.de>,
	avaneesh.dwivedi@oss.qualcomm.com,
	Umang Chheda <umang.chheda@oss.qualcomm.com>,
	linux-kernel@vger.kernel.org, kernel@pengutronix.de,
	Srinivas Kandagatla <srini@kernel.org>, devicetree@vger.kernel.org,
	Liam Girdwood <lgirdwood@gmail.com>,
	Wim Van Sebroeck <wim@linux-watchdog.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	linux-watchdog@vger.kernel.org
Subject: Re: [PATCH v3 1/3] dt-bindings: nvmem: layouts: Add PSCRR NVMEM
 layout
Message-ID: <179026318341.88360.3982183548324644343.robh@kernel.org>
References: <20260914-pscrr-provider-v3-0-c45cb16542e8@oss.qualcomm.com>
 <20260914-pscrr-provider-v3-1-c45cb16542e8@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-watchdog@vger.kernel.org
List-Id: <linux-watchdog.vger.kernel.org>
List-Subscribe: <mailto:linux-watchdog+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-watchdog+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260914-pscrr-provider-v3-1-c45cb16542e8@oss.qualcomm.com>


On Mon, 14 Sep 2026 10:08:45 +0530, Faruque Ansari wrote:
> Add a schema for the PSCRR NVMEM layout, which persists the power
> state change reason in a single NVMEM cell so it survives a power
> cycle and can be read back on the next boot.
> 
> Signed-off-by: Faruque Ansari <faruque.ansari@oss.qualcomm.com>
> ---
>  .../bindings/nvmem/layouts/nvmem-layout.yaml       |  1 +
>  .../bindings/nvmem/layouts/pscrr-nvmem.yaml        | 87 ++++++++++++++++++++++
>  MAINTAINERS                                        |  1 +
>  3 files changed, 89 insertions(+)
> 

Reviewed-by: Rob Herring (Arm) <robh@kernel.org>

