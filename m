Return-Path: <p.paillet@st.com>
Return-path: <p.paillet@st.com>
From: Pascal PAILLET-LME <p.paillet@st.com>
To: "dmitry.torokhov@gmail.com" <dmitry.torokhov@gmail.com>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "mark.rutland@arm.com"
	<mark.rutland@arm.com>,
        "lee.jones@linaro.org" <lee.jones@linaro.org>,
        "lgirdwood@gmail.com" <lgirdwood@gmail.com>,
        "broonie@kernel.org"
	<broonie@kernel.org>,
        "wim@linux-watchdog.org" <wim@linux-watchdog.org>,
        "linux@roeck-us.net" <linux@roeck-us.net>,
        "linux-input@vger.kernel.org"
	<linux-input@vger.kernel.org>,
        "devicetree@vger.kernel.org"
	<devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>,
        "linux-watchdog@vger.kernel.org"
	<linux-watchdog@vger.kernel.org>,
        "benjamin.gaignard@linaro.org"
	<benjamin.gaignard@linaro.org>,
        "eballetbo@gmail.com" <eballetbo@gmail.com>
CC: Pascal PAILLET-LME <p.paillet@st.com>
Subject: [PATCH v4 3/8] dt-bindings: regulator: document stpmic1 pmic
 regulators
Date: Thu, 18 Oct 2018 09:02:12 +0000
Message-ID: <1539853324-29051-4-git-send-email-p.paillet@st.com>
References: <1539853324-29051-1-git-send-email-p.paillet@st.com>
In-Reply-To: <1539853324-29051-1-git-send-email-p.paillet@st.com>
Content-Language: en-US
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
List-ID: <linux-watchdog@vger.kernel.org>

From: pascal paillet <p.paillet@st.com>

The STPMIC1 regulators supply power to the application processor as well as
to the external system peripherals such as DDR, Flash memories and system
devices.

Signed-off-by: pascal paillet <p.paillet@st.com>
Reviewed-by: Rob Herring <robh@kernel.org>

---
changes in v4: nothing

 .../bindings/regulator/st,stpmic1-regulator.txt    | 68 ++++++++++++++++++=
++++
 1 file changed, 68 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/regulator/st,stpmic1-=
regulator.txt

diff --git a/Documentation/devicetree/bindings/regulator/st,stpmic1-regulat=
or.txt b/Documentation/devicetree/bindings/regulator/st,stpmic1-regulator.t=
xt
new file mode 100644
index 0000000..a3f4762
--- /dev/null
+++ b/Documentation/devicetree/bindings/regulator/st,stpmic1-regulator.txt
@@ -0,0 +1,68 @@
+STMicroelectronics STPMIC1 Voltage regulators
+
+Regulator Nodes are optional depending on needs.
+
+Available Regulators in STPMIC1 device are:
+  - buck1 for Buck BUCK1
+  - buck2 for Buck BUCK2
+  - buck3 for Buck BUCK3
+  - buck4 for Buck BUCK4
+  - ldo1 for LDO LDO1
+  - ldo2 for LDO LDO2
+  - ldo3 for LDO LDO3
+  - ldo4 for LDO LDO4
+  - ldo5 for LDO LDO5
+  - ldo6 for LDO LDO6
+  - vref_ddr for LDO Vref DDR
+  - boost for Buck BOOST
+  - pwr_sw1 for VBUS_OTG switch
+  - pwr_sw2 for SW_OUT switch
+
+Switches are fixed voltage regulators with only enable/disable capability.
+
+Optional properties:
+- st,mask-reset: mask reset for this regulator: the regulator configuratio=
n
+  is maintained during pmic reset.
+- regulator-pull-down: enable high pull down
+  if not specified light pull down is used
+- regulator-over-current-protection:
+    if set, all regulators are switched off in case of over-current detect=
ion
+    on this regulator,
+    if not set, the driver only sends an over-current event.
+- interrupt-parent: phandle to the parent interrupt controller
+- interrupts: index of current limit detection interrupt
+- <regulator>-supply: phandle to the parent supply/regulator node
+	each regulator supply can be described except vref_ddr.
+
+Example:
+regulators {
+	compatible =3D "st,stpmic1-regulators";
+
+	ldo6-supply =3D <&v3v3>;
+
+	vdd_core: buck1 {
+		regulator-name =3D "vdd_core";
+		interrupts =3D <IT_CURLIM_BUCK1 0>;
+		interrupt-parent =3D <&pmic>;
+		st,mask-reset;
+		regulator-pull-down;
+		regulator-min-microvolt =3D <700000>;
+		regulator-max-microvolt =3D <1200000>;
+	};
+
+	v3v3: buck4 {
+		regulator-name =3D "v3v3";
+		interrupts =3D <IT_CURLIM_BUCK4 0>;
+		interrupt-parent =3D <&mypmic>;
+
+		regulator-min-microvolt =3D <3300000>;
+		regulator-max-microvolt =3D <3300000>;
+	};
+
+	v1v8: ldo6 {
+		regulator-name =3D "v1v8";
+		regulator-min-microvolt =3D <1800000>;
+		regulator-max-microvolt =3D <1800000>;
+		regulator-over-current-protection;
+	};
+};
--=20
1.9.1
