Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ADC6E3AA51C;
	Mon, 23 Mar 2026 13:24:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774272256; cv=none; b=G6tmNkhmiBiZWlkyPT2eMYzhaDvJ2gZEd9Dc+hfDcEYza9Vv8GIZNoNpxE8lVT/vgIT7M2yqWjoQ+R1C8j/AOEtaSy0/wf8GKLa72c5v9+dUwlXro3ZAE7ag8HU27YiDMMOJhya5qvzpuCmr0Ctb5bzUlL6YN3GMUtIHAGUA5eM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774272256; c=relaxed/simple;
	bh=yrsAO96whaggG9rvgjgOdIWNmDJNVbOszVkiTUcN9AE=;
	h=Date:Content-Type:MIME-Version:From:Cc:To:In-Reply-To:References:
	 Message-Id:Subject; b=Gx/ZbClreLi+5pMl/NqdMhZJVt6s+5s47JWTfK0/SVxJmK/c9NkAfK7kIEctzO/c5Bu6AJnQlI94kLa50tw8Ak3N47AEn4SFpIl6bkWXjIgc94vrKs8bPfcL751bMbj/2ogaypfk+pm8buuRUzRv/QEB6+9+eezNFqxsu8U2KYc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SoF7E7Sr; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SoF7E7Sr"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4EBD5C2BCB1;
	Mon, 23 Mar 2026 13:24:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1774272256;
	bh=yrsAO96whaggG9rvgjgOdIWNmDJNVbOszVkiTUcN9AE=;
	h=Date:From:Cc:To:In-Reply-To:References:Subject:From;
	b=SoF7E7SrTyvmSwzXVD60JKAftzWuicZny0+4m7cMrgQV/s1AYPTTOMjLiT80YAdKZ
	 q+kXT04vd28vOyqcdhfI6gHfPk4gLj4D4mUQkSSY97NK7XiyZa0c59IDy+RMdv3zqf
	 dI44jDH4WD/MLFPh2+I1teRqGAOaq0YZ2lhM7i5UXjniXTnKAUj5xw0nmo0xj9fc1f
	 fV2xvH2NsgQWKjRrcxjL4ub/ptoKOubCVV+aeiiVkDM+P93J0nkF6kSBJ8Qtzcg5oF
	 NT1PqRLAVvbWSAMhkSFV1LOqwufF8UU1pIvyJIFBveJNB4NUzmY1MNS+V0AGPqwJH3
	 NiiQcqYTVLNIw==
Date: Mon, 23 Mar 2026 08:24:15 -0500
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: linux-watchdog@vger.kernel.org
List-Id: <linux-watchdog.vger.kernel.org>
List-Subscribe: <mailto:linux-watchdog+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-watchdog+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: "Rob Herring (Arm)" <robh@kernel.org>
Cc: Mark Brown <broonie@kernel.org>, daniel.baluta@nxp.com, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Fabio Estevam <festevam@gmail.com>, linux-arm-kernel@lists.infradead.org, 
 Wim Van Sebroeck <wim@linux-watchdog.org>, 
 Conor Dooley <conor+dt@kernel.org>, devicetree@vger.kernel.org, 
 Pengutronix Kernel Team <kernel@pengutronix.de>, 
 Guenter Roeck <linux@roeck-us.net>, Sascha Hauer <s.hauer@pengutronix.de>, 
 linux-kernel@vger.kernel.org, imx@lists.linux.dev, 
 Frank Li <Frank.Li@nxp.com>, linux-watchdog@vger.kernel.org, d-gole@ti.com, 
 m-chawdhry@ti.com, simona.toaca@nxp.com
To: Eduard Bostina <egbostina@gmail.com>
In-Reply-To: <20260323084616.10469-2-egbostina@gmail.com>
References: <20260323084616.10469-1-egbostina@gmail.com>
 <20260323084616.10469-2-egbostina@gmail.com>
Message-Id: <177427225351.450652.11241524058858520002.robh@kernel.org>
Subject: Re: [PATCH 1/2] dt-bindings: watchdog: Convert TS-4800 to DT
 schema


On Mon, 23 Mar 2026 10:46:12 +0200, Eduard Bostina wrote:
> Convert the Technologic Systems TS-4800 watchdog timer bindings
> to DT schema.
> 
> Signed-off-by: Eduard Bostina <egbostina@gmail.com>
> ---
> Note:
> * This patch is part of the GSoC2026 application process for device tree bindings conversions
> * https://github.com/LinuxFoundationGSoC/ProjectIdeas/wiki/GSoC-2026-Device-Tree-Bindings
> 
>  .../watchdog/technologic,ts4800-wdt.yaml      | 46 +++++++++++++++++++
>  .../bindings/watchdog/ts4800-wdt.txt          | 25 ----------
>  2 files changed, 46 insertions(+), 25 deletions(-)
>  create mode 100644 Documentation/devicetree/bindings/watchdog/technologic,ts4800-wdt.yaml
>  delete mode 100644 Documentation/devicetree/bindings/watchdog/ts4800-wdt.txt
> 

My bot found errors running 'make dt_binding_check' on your patch:

yamllint warnings/errors:

dtschema/dtc warnings/errors:
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/watchdog/technologic,ts4800-wdt.example.dtb: syscon@b0010000 (syscon): compatible: ['syscon', 'simple-mfd'] is too short
	from schema $id: http://devicetree.org/schemas/mfd/syscon-common.yaml

doc reference errors (make refcheckdocs):

See https://patchwork.kernel.org/project/devicetree/patch/20260323084616.10469-2-egbostina@gmail.com

The base for the series is generally the latest rc1. A different dependency
should be noted in *this* patch.

If you already ran 'make dt_binding_check' and didn't see the above
error(s), then make sure 'yamllint' is installed and dt-schema is up to
date:

pip3 install dtschema --upgrade

Please check and re-submit after running the above command yourself. Note
that DT_SCHEMA_FILES can be set to your schema file to speed up checking
your schema. However, it must be unset to test all examples with your schema.

