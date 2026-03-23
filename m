Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 96E143009F6;
	Mon, 23 Mar 2026 08:45:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774255548; cv=none; b=tXUUx6RN4sjWoJwk7F3z/84GxYxSFo0lLKGiRjVbf4VWcUNVvxvAOIv15bILKHXwqieXYFFV1fyOd1rQommX0tZ1oZC8GcohrOIoLxNP87Ssk4EBQnWPoG2d4m+sDP4za4iJZDKQY4YKvfehUPzrBw+/3GV7sHOiAgUuJrIqCg8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774255548; c=relaxed/simple;
	bh=IZrg3073YvRn5Dp2yAL/QnRBIbaZV1wKQhSYGwFdg0w=;
	h=Mime-Version:Content-Type:Date:Message-Id:Subject:Cc:From:To:
	 References:In-Reply-To; b=gth8udZDLHCvSGfJESuawaTUWN4tC+UgNowfrYH0ckl1ekusjrK1ucdVUtKBBt/4gXXAhc7lfcwGMr6EZdrvRXhtkGEglwMwHa77OQbGzOvZYZIVEbUDXaF1ZAgWbmfledIpwAd/2qZKPry/ONF07KNJ/BQ0YSjcrHsuG6zZw0c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MqZJJ+jE; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MqZJJ+jE"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DE996C4CEF7;
	Mon, 23 Mar 2026 08:45:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1774255548;
	bh=IZrg3073YvRn5Dp2yAL/QnRBIbaZV1wKQhSYGwFdg0w=;
	h=Date:Subject:Cc:From:To:References:In-Reply-To:From;
	b=MqZJJ+jEXv66rnW751yqXlW9hMqAGiXOgu5FRwFFx4ERxXcucMsrpn0wmuKJyfre/
	 z0b2cJa57c4a6Pzy04GpXyRidWJ14kWnKCMRi3eeULZh/K087FrQ0KiP/6lcPknEGs
	 bjtsxeanA+J5BKE+ZiRQf+wqwO+vFnjITVtnOxoRUQjMDf3IUln1PWB+DJ2vtIiPFc
	 9VcUX83Ma/9wRdW0/nn2KvTkgW4sQrC6fQR3RDYbnpG9qXCIPoI7NgcxKtqyxs9KqJ
	 njgU6s/2VapcsTCeQmQ/TjhQZDWpDW+ks0UZn01j5x3HfuNems7N6rLOvemIejM8D6
	 ur2+jgFfIaHLg==
Precedence: bulk
X-Mailing-List: linux-watchdog@vger.kernel.org
List-Id: <linux-watchdog.vger.kernel.org>
List-Subscribe: <mailto:linux-watchdog+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-watchdog+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: multipart/signed;
 boundary=bd4a73f9dd4d15328054ccc0b5312fbbd2fc1c943838d1efe8c042901083;
 micalg=pgp-sha384; protocol="application/pgp-signature"
Date: Mon, 23 Mar 2026 09:45:37 +0100
Message-Id: <DHA13HM1GIJW.1E7XCMY349JX7@kernel.org>
Subject: Re: [PATCH v2 6/7] dt-bindings: watchdog: Drop SMARC-sAM67 support
Cc: <linux-arm-kernel@lists.infradead.org>, <devicetree@vger.kernel.org>,
 <linux-kernel@vger.kernel.org>, <linux-hwmon@vger.kernel.org>,
 <linux-watchdog@vger.kernel.org>, <linux-doc@vger.kernel.org>, "Conor
 Dooley" <conor.dooley@microchip.com>
From: "Michael Walle" <mwalle@kernel.org>
To: "Guenter Roeck" <linux@roeck-us.net>, "Nishanth Menon" <nm@ti.com>,
 "Vignesh Raghavendra" <vigneshr@ti.com>, "Tero Kristo" <kristo@kernel.org>,
 "Rob Herring" <robh@kernel.org>, "Krzysztof Kozlowski"
 <krzk+dt@kernel.org>, "Conor Dooley" <conor+dt@kernel.org>, "Srinivas
 Kandagatla" <srini@kernel.org>, "Wim Van Sebroeck"
 <wim@linux-watchdog.org>, "Jonathan Corbet" <corbet@lwn.net>, "Shuah Khan"
 <skhan@linuxfoundation.org>
X-Mailer: aerc 0.20.0
References: <20260302122540.1377444-1-mwalle@kernel.org>
 <20260302122540.1377444-7-mwalle@kernel.org>
 <f124b200-09e3-4e73-a100-f47007732e8f@roeck-us.net>
In-Reply-To: <f124b200-09e3-4e73-a100-f47007732e8f@roeck-us.net>

--bd4a73f9dd4d15328054ccc0b5312fbbd2fc1c943838d1efe8c042901083
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8

Hi,

On Mon Mar 2, 2026 at 4:01 PM CET, Guenter Roeck wrote:
> On 3/2/26 04:24, Michael Walle wrote:
>> I was just informed that this product is discontinued (without being
>> ever released to the market). Pull the plug and let's not waste any more
>> maintainers time and revert commit 354f31e9d2a3 ("dt-bindings: watchdog:
>> Add SMARC-sAM67 support").
>>=20
>> Acked-by: Conor Dooley <conor.dooley@microchip.com>
>> Signed-off-by: Michael Walle <mwalle@kernel.org>
>
> Reviewed-by: Guenter Roeck <linux@roeck-us.net>

Everything expect this patch was picked up. Guenter, do you want to
take it, or should it go through the TI SoC queue?

Thanks,
-michael

--bd4a73f9dd4d15328054ccc0b5312fbbd2fc1c943838d1efe8c042901083
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iKgEABMJADAWIQTIVZIcOo5wfU/AngkSJzzuPgIf+AUCacD9sxIcbXdhbGxlQGtl
cm5lbC5vcmcACgkQEic87j4CH/j8xgF/YE8auGYf7y4fj5Wh1h3SKh5Yl6dpVBAG
OKsJlsNtaEhDxOMkeG3zYURQ/NqDSjQ+AYCRn1+pOiDB/8sAFVZx1L9i4pZWq3cQ
Eidq3hJvghVNoQcTlcufj4jMfOPRjSUh4QU=
=P+gh
-----END PGP SIGNATURE-----

--bd4a73f9dd4d15328054ccc0b5312fbbd2fc1c943838d1efe8c042901083--
