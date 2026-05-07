Received: from gloria.sntech.de (gloria.sntech.de [185.11.138.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4396736C9EE;
	Thu,  7 May 2026 11:22:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.11.138.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778152958; cv=none; b=QJcWiUnG43A/OmTR0LKZwIXi6MEZqgNmT7AucdKf6Cs3SngL9H28eUscnoUt3ra5OZh4FE0OQW+SQIiYKg9FNNL1ICa3wAOqmd9U0RAh0w3Y1ILmdHOnAv8WX5U22FHdyNd2pRU83kik4FUCcgAz3ISlWGxPm1V6MH0v4G4LlpQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778152958; c=relaxed/simple;
	bh=O1zck4BnnxGkwMbkT9Sw3XfFU9KU0+jef56nHYpbkG8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=pTq4bghwdwyWLkDWWusx8YhVwKzI+MqLBsiaW3eeMOgITqt279zBFiKhq7vmJPqrI9oeXzj2uNiSRI2ZtK5FS4BsauSzR9vh9j8dCTEc0qI/pYdUBOoYBqY+VH5t3qDCf6jYh7VYHQn2ok9DUvus6m/fCWSVuZsgjSSfSLKkx8k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=sntech.de; spf=pass smtp.mailfrom=sntech.de; dkim=pass (2048-bit key) header.d=sntech.de header.i=@sntech.de header.b=Dsvvvf2u; arc=none smtp.client-ip=185.11.138.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=sntech.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sntech.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sntech.de header.i=@sntech.de header.b="Dsvvvf2u"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sntech.de;
	s=gloria202408; h=Content-Type:Content-Transfer-Encoding:MIME-Version:
	References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Reply-To;
	bh=yErPCaBbwwzdpT7W/KiFQy3vHc4b8ADLq+ts14Y24bY=; b=Dsvvvf2uChu9h5/5rmHYGioD9y
	+rLCJpUP3KZP3NttKdgTuNxuWUQq0jw3s/raaJja8xzEdUE2Yk2aVf+aO014NukbGwzVs+gKxoTNP
	AK84XHvaKjNa0aDabEpcLk8UeuZQeW7NUhLZU4QaA7aoh6rKdtyKzBWn2wXEA9CMTeVql/yDt8hy3
	LCvRnXvHuXUGPygYj5CAj59xlYxckMieMhIwlHQNjCvjwIdpyYxfzBXvnZxRDD9ZEZV/RXtBtwT8/
	+g7kGGakw4qt1eUcpq4wYQxf1BJAnN/QgRFqBvDMaqLTNfx1UqXJv7Jjh0l+KXXIBJE5dCJ712Y4E
	seK9KgVg==;
From: Heiko Stuebner <heiko@sntech.de>
To: Fabio Estevam <festevam@gmail.com>, Guenter Roeck <linux@roeck-us.net>
Cc: wim@linux-watchdog.org, robh@kernel.org, krzk+dt@kernel.org,
 conor+dt@kernel.org, linux-watchdog@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 Fabio Estevam <festevam@nabladev.com>
Subject:
 Re: [PATCH v2] dt-bindings: watchdog: rockchip: Add RV1103B compatible
Date: Thu, 07 May 2026 13:22:13 +0200
Message-ID: <5466403.V25eIC5XRa@phil>
In-Reply-To: <066e3058-5ba8-4695-9f45-523c7d43ab76@roeck-us.net>
References:
 <20260310002040.417424-1-festevam@gmail.com>
 <CAOMZO5DFWYUPN9sPzBr-W7fy8ZbrXP7u1sx=HrmUAQVCLrsdjQ@mail.gmail.com>
 <066e3058-5ba8-4695-9f45-523c7d43ab76@roeck-us.net>
Precedence: bulk
X-Mailing-List: linux-watchdog@vger.kernel.org
List-Id: <linux-watchdog.vger.kernel.org>
List-Subscribe: <mailto:linux-watchdog+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-watchdog+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="utf-8"

Am Freitag, 10. April 2026, 17:49:55 Mitteleurop=C3=A4ische Sommerzeit schr=
ieb Guenter Roeck:
> On 4/8/26 03:28, Fabio Estevam wrote:
> > Hi Guenter,
> >=20
> > On Mon, Mar 16, 2026 at 11:14=E2=80=AFAM Guenter Roeck <linux@roeck-us.=
net> wrote:
> >>
> >> On 3/9/26 17:20, Fabio Estevam wrote:
> >>> From: Fabio Estevam <festevam@nabladev.com>
> >>>
> >>> The RV1103B watchdog is compatible with the existing DesignWare Watch=
dog
> >>> binding. Add the rockchip,rv1103b-wdt compatible string.
> >>>
> >>> Signed-off-by: Fabio Estevam <festevam@nabladev.com>
> >>
> >> Reviewed-by: Guenter Roeck <linux@roeck-us.net>
> >=20
> > Could you please apply this one?
>=20
> Wim applies watchdog subsystem patches.

seems to have changed, as it was applied as
  https://git.kernel.org/pub/scm/linux/kernel/git/groeck/linux-staging.git/=
commit/?h=3Dwatchdog-next&id=3D882fc25d868fbd0d71751df4df49c4b55e3fa230

@Fabio, I guess you can send that rv1103b watchdog devicetree
node now.

Heiko




