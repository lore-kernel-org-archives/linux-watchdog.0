Received: from mail-m16.yeah.net (mail-m16.yeah.net [1.95.21.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 410B8277CBB;
	Tue,  1 Jul 2025 14:14:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=1.95.21.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751379277; cv=none; b=hRMNx2Ysgp59nWQuk0IRgeOdlKxXdvzgkbBorTbUqJ7LbISUIWIu6Saw+cLBfmSwMbhbvcKK0mx7gywfce0CE1xe7lMtg8/tmi4becKiexaY4Uakkulv3LP4TULQobyjcndDfAyiiIFBys7vh8e5WY/BoY3nXPjdUJBnEtZn2Yw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751379277; c=relaxed/simple;
	bh=INugTqBVM7fToZCIvxlUMkZxsPpLlqW6VEdnb21T200=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=F3lYn5ck32XB0N2q/qVP7s3mf+DcQvIwIAExbLGdoqmbmlv/qWvjsDEJtr2vZq0Kv4buUGLf2WJu6tNKznWqm1gQIvC3ZWyj2/iK9Q2oNajrm1MZexAC3R6fS0s0p4vF8DZ3sHe92hoPI/rLBaYHZk9whZW/on4tyPj/ag6Avbg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=yeah.net; spf=pass smtp.mailfrom=yeah.net; dkim=pass (1024-bit key) header.d=yeah.net header.i=@yeah.net header.b=gFuevKNR; arc=none smtp.client-ip=1.95.21.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=yeah.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=yeah.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=yeah.net header.i=@yeah.net header.b="gFuevKNR"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yeah.net;
	s=s110527; h=Date:From:To:Subject:Message-ID:MIME-Version:
	Content-Type; bh=UgVcaTMaZwQKG0vFQL59Zz76XRt+0Z5vWGwWG9Mrcpw=;
	b=gFuevKNRJo4o54DWHlJLiUMQBuWMzoWzwImK/JXY8XYu7CrEvAqhSaeQ8LYDTX
	50TbYpj26O6tdp9RbFri9qZ+zKFzLkXuEySPe85cbSIB2mxygYXOX9Uh2T4jnZb7
	ZbtHQDkaQPu+H898TFGKZAj/2iOFtPypm+GE5pdUFUuxA=
Received: from dragon (unknown [])
	by gzsmtp3 (Coremail) with SMTP id M88vCgD3l9r37GNoUbwBAA--.4338S3;
	Tue, 01 Jul 2025 22:13:13 +0800 (CST)
Date: Tue, 1 Jul 2025 22:13:11 +0800
From: Shawn Guo <shawnguo2@yeah.net>
To: Thomas Richard <thomas.richard@bootlin.com>
Cc: Wim Van Sebroeck <wim@linux-watchdog.org>,
	Guenter Roeck <linux@roeck-us.net>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Dong Aisheng <aisheng.dong@nxp.com>,
	Shawn Guo <shawnguo@kernel.org>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	Fabio Estevam <festevam@gmail.com>,
	Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
	linux-watchdog@vger.kernel.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, imx@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org,
	Oliver Graute <oliver.graute@kococonnector.com>,
	Frank Li <Frank.Li@nxp.com>
Subject: Re: [PATCH v3] arm64: dts: imx8qm: add system controller watchdog
 support
Message-ID: <aGPs9wGBLKGiTdVq@dragon>
References: <20250609-imx8qm-watchdog-v3-1-5c22618606c8@bootlin.com>
Precedence: bulk
X-Mailing-List: linux-watchdog@vger.kernel.org
List-Id: <linux-watchdog.vger.kernel.org>
List-Subscribe: <mailto:linux-watchdog+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-watchdog+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250609-imx8qm-watchdog-v3-1-5c22618606c8@bootlin.com>
X-CM-TRANSID:M88vCgD3l9r37GNoUbwBAA--.4338S3
X-Coremail-Antispam: 1Uf129KBjDUn29KB7ZKAUJUUUUU529EdanIXcx71UUUUU7v73
	VFW2AGmfu7bjvjm3AaLaJ3UbIYCTnIWIevJa73UjIFyTuYvjxUw-eOUUUUU
X-CM-SenderInfo: pvkd40hjxrjqh1hdxhhqhw/1tbiIRls0Whj7Pkt0wAA3l

On Mon, Jun 09, 2025 at 02:02:34PM +0200, Thomas Richard wrote:
> Add system controller watchdog support for i.MX8QM.
> 
> Acked-by: Oliver Graute <oliver.graute@kococonnector.com>
> Reviewed-by: Frank Li <Frank.Li@nxp.com>
> Signed-off-by: Thomas Richard <thomas.richard@bootlin.com>

Applied, thanks!

