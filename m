Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from mga01.intel.com ([192.55.52.88]:26895 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751501AbdGYKkM (ORCPT <rfc822;linux-watchdog@vger.kernel.org>);
        Tue, 25 Jul 2017 06:40:12 -0400
Message-ID: <1500979206.29303.228.camel@linux.intel.com>
Subject: Re: [PATCH v1 1/6] efi: Switch to use new generic UUID API
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Ard Biesheuvel <ard.biesheuvel@linaro.org>
Cc: "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>,
        devel@linuxdriverproject.org, sparmaintainer@unisys.com,
        devel@driverdev.osuosl.org,
        "<linux-wireless@vger.kernel.org>" <linux-wireless@vger.kernel.org>,
        linux-watchdog@vger.kernel.org,
        "linux-efi@vger.kernel.org" <linux-efi@vger.kernel.org>,
        Christoph Hellwig <hch@lst.de>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Lukas Wunner <lukas@wunner.de>,
        Matt Fleming <matt@codeblueprint.co.uk>
Date: Tue, 25 Jul 2017 13:40:06 +0300
In-Reply-To: <CAKv+Gu8Et3smOv9Of47q6VGa9yn9u+vuhS_1B5yg_QULsS4Obg@mail.gmail.com>
References: <20170719182857.73693-1-andriy.shevchenko@linux.intel.com>
         <20170719182857.73693-2-andriy.shevchenko@linux.intel.com>
         <CAKv+Gu8Et3smOv9Of47q6VGa9yn9u+vuhS_1B5yg_QULsS4Obg@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org
Content-Transfer-Encoding: quoted-printable

On Thu, 2017-07-20 at 13:18 +0100, Ard Biesheuvel wrote:
> On 19 July 2017 at 19:28, Andy Shevchenko
> <andriy.shevchenko@linux.intel.com> wrote:
> > There are new types and helpers that are supposed to be used in new
> > code.
> >=20
> > As a preparation to get rid of legacy types and API functions do
> > the conversion here.
> >=20
> > Cc: Matt Fleming <matt@codeblueprint.co.uk>
> > Cc: Ard Biesheuvel <ard.biesheuvel@linaro.org>
> > Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
>=20
> Acked-by: Ard Biesheuvel <ard.biesheuvel@linaro.org>


Thanks!

Christoph, can we apply this one at least to move things forward?

>=20
> > ---
> > =C2=A0drivers/firmware/efi/cper.c | 10 ++---
> > =C2=A0include/linux/cper.h=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0| 94 ++++++++++++++++++++++----------
> > -------------
> > =C2=A0include/linux/efi.h=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0|=C2=A0=C2=A04 +-
> > =C2=A03 files changed, 54 insertions(+), 54 deletions(-)
> >=20
> > diff --git a/drivers/firmware/efi/cper.c
> > b/drivers/firmware/efi/cper.c
> > index 48a8f69da42a..684e65c11dde 100644
> > --- a/drivers/firmware/efi/cper.c
> > +++ b/drivers/firmware/efi/cper.c
> > @@ -534,7 +534,7 @@ static void
> > =C2=A0cper_estatus_print_section(const char *pfx, struct
> > acpi_hest_generic_data *gdata,
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0int sec_no)
> > =C2=A0{
> > -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0uuid_le *sec_type =3D (uui=
d_le *)gdata->section_type;
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0guid_t *sec_type =3D (guid=
_t *)gdata->section_type;
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0__u16 severity;
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0char newpfx[64];
> >=20
> > @@ -545,12 +545,12 @@ cper_estatus_print_section(const char *pfx,
> > struct acpi_hest_generic_data *gdata
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0printk("%s""Error %d,=
 type: %s\n", pfx, sec_no,
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0cper_severity_str(severity));
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0if (gdata->validation=
_bits & CPER_SEC_VALID_FRU_ID)
> > -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0printk("%s""fru_id: %pUl\n", pfx, (uuid_le *)gdata-
> > >fru_id);
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0printk("%s""fru_id: %pUl\n", pfx, gdata->fru_id);
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0if (gdata->validation=
_bits & CPER_SEC_VALID_FRU_TEXT)
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0printk("%s""fru_text: %.20s\n", pfx, gdata-
> > >fru_text);
> >=20
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0snprintf(newpfx, size=
of(newpfx), "%s%s", pfx, INDENT_SP);
> > -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0if (!uuid_le_cmp(*sec_type=
, CPER_SEC_PROC_GENERIC)) {
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0if (guid_equal(sec_type, &=
CPER_SEC_PROC_GENERIC)) {
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0struct cper_sec_proc_generic *proc_err =3D
> > acpi_hest_get_payload(gdata);
> >=20
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0printk("%s""section_type: general processor
> > error\n", newpfx);
> > @@ -558,7 +558,7 @@ cper_estatus_print_section(const char *pfx,
> > struct acpi_hest_generic_data *gdata
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
cper_print_proc_generic(newpfx, proc_err);
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0else
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
goto err_section_too_small;
> > -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0} else if (!uuid_le_cmp(*s=
ec_type, CPER_SEC_PLATFORM_MEM)) {
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0} else if (guid_equal(sec_=
type, &CPER_SEC_PLATFORM_MEM)) {
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0struct cper_sec_mem_err *mem_err =3D
> > acpi_hest_get_payload(gdata);
> >=20
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0printk("%s""section_type: memory error\n", new=
pfx);
> > @@ -568,7 +568,7 @@ cper_estatus_print_section(const char *pfx,
> > struct acpi_hest_generic_data *gdata
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0gdata->error_data_length);
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0else
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
goto err_section_too_small;
> > -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0} else if (!uuid_le_cmp(*s=
ec_type, CPER_SEC_PCIE)) {
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0} else if (guid_equal(sec_=
type, &CPER_SEC_PCIE)) {
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0struct cper_sec_pcie *pcie =3D
> > acpi_hest_get_payload(gdata);
> >=20
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0printk("%s""section_type: PCIe error\n", newpf=
x);
> > diff --git a/include/linux/cper.h b/include/linux/cper.h
> > index 4c671fc2081e..723e952fde0d 100644
> > --- a/include/linux/cper.h
> > +++ b/include/linux/cper.h
> > @@ -74,36 +74,36 @@ enum {
> > =C2=A0 * Corrected Machine Check
> > =C2=A0 */
> > =C2=A0#define
> > CPER_NOTIFY_CMC=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0
> > =C2=A0=C2=A0=C2=A0\
> > -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0UUID_LE(0x2DCE8BB1, 0xBDD7=
, 0x450e, 0xB9, 0xAD, 0x9C,
> > 0xF4,=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0\
> > -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A00xEB, 0xD4, 0xF8, 0x90)
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0GUID_INIT(0x2DCE8BB1, 0xBD=
D7, 0x450e, 0xB9, 0xAD, 0x9C,
> > 0xF4,=C2=A0=C2=A0=C2=A0\
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A00xEB, 0xD4, 0xF8, 0x90)
> > =C2=A0/* Corrected Platform Error */
> > =C2=A0#define
> > CPER_NOTIFY_CPE=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0
> > =C2=A0=C2=A0=C2=A0\
> > -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0UUID_LE(0x4E292F96, 0xD843=
, 0x4a55, 0xA8, 0xC2, 0xD4,
> > 0x81,=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0\
> > -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A00xF2, 0x7E, 0xBE, 0xEE)
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0GUID_INIT(0x4E292F96, 0xD8=
43, 0x4a55, 0xA8, 0xC2, 0xD4,
> > 0x81,=C2=A0=C2=A0=C2=A0\
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A00xF2, 0x7E, 0xBE, 0xEE)
> > =C2=A0/* Machine Check Exception */
> > =C2=A0#define
> > CPER_NOTIFY_MCE=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0
> > =C2=A0=C2=A0=C2=A0\
> > -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0UUID_LE(0xE8F56FFE, 0x919C=
, 0x4cc5, 0xBA, 0x88, 0x65,
> > 0xAB,=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0\
> > -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A00xE1, 0x49, 0x13, 0xBB)
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0GUID_INIT(0xE8F56FFE, 0x91=
9C, 0x4cc5, 0xBA, 0x88, 0x65,
> > 0xAB,=C2=A0=C2=A0=C2=A0\
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A00xE1, 0x49, 0x13, 0xBB)
> > =C2=A0/* PCI Express Error */
> > =C2=A0#define
> > CPER_NOTIFY_PCIE=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0\
> > -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0UUID_LE(0xCF93C01F, 0x1A16=
, 0x4dfc, 0xB8, 0xBC, 0x9C,
> > 0x4D,=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0\
> > -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A00xAF, 0x67, 0xC1, 0x04)
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0GUID_INIT(0xCF93C01F, 0x1A=
16, 0x4dfc, 0xB8, 0xBC, 0x9C,
> > 0x4D,=C2=A0=C2=A0=C2=A0\
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A00xAF, 0x67, 0xC1, 0x04)
> > =C2=A0/* INIT Record (for IPF) */
> > =C2=A0#define
> > CPER_NOTIFY_INIT=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0\
> > -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0UUID_LE(0xCC5263E8, 0x9308=
, 0x454a, 0x89, 0xD0, 0x34,
> > 0x0B,=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0\
> > -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A00xD3, 0x9B, 0xC9, 0x8E)
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0GUID_INIT(0xCC5263E8, 0x93=
08, 0x454a, 0x89, 0xD0, 0x34,
> > 0x0B,=C2=A0=C2=A0=C2=A0\
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A00xD3, 0x9B, 0xC9, 0x8E)
> > =C2=A0/* Non-Maskable Interrupt */
> > =C2=A0#define
> > CPER_NOTIFY_NMI=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0
> > =C2=A0=C2=A0=C2=A0\
> > -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0UUID_LE(0x5BAD89FF, 0xB7E6=
, 0x42c9, 0x81, 0x4A, 0xCF,
> > 0x24,=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0\
> > -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A00x85, 0xD6, 0xE9, 0x8A)
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0GUID_INIT(0x5BAD89FF, 0xB7=
E6, 0x42c9, 0x81, 0x4A, 0xCF,
> > 0x24,=C2=A0=C2=A0=C2=A0\
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A00x85, 0xD6, 0xE9, 0x8A)
> > =C2=A0/* BOOT Error Record */
> > =C2=A0#define
> > CPER_NOTIFY_BOOT=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0\
> > -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0UUID_LE(0x3D61A466, 0xAB40=
, 0x409a, 0xA6, 0x98, 0xF3,
> > 0x62,=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0\
> > -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A00xD4, 0x64, 0xB3, 0x8F)
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0GUID_INIT(0x3D61A466, 0xAB=
40, 0x409a, 0xA6, 0x98, 0xF3,
> > 0x62,=C2=A0=C2=A0=C2=A0\
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A00xD4, 0x64, 0xB3, 0x8F)
> > =C2=A0/* DMA Remapping Error */
> > =C2=A0#define
> > CPER_NOTIFY_DMAR=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0\
> > -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0UUID_LE(0x667DD791, 0xC6B3=
, 0x4c27, 0x8A, 0x6B, 0x0F,
> > 0x8E,=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0\
> > -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A00x72, 0x2D, 0xEB, 0x41)
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0GUID_INIT(0x667DD791, 0xC6=
B3, 0x4c27, 0x8A, 0x6B, 0x0F,
> > 0x8E,=C2=A0=C2=A0=C2=A0\
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A00x72, 0x2D, 0xEB, 0x41)
> >=20
> > =C2=A0/*
> > =C2=A0 * Flags bits definitions for flags in struct cper_record_heade=
r
> > @@ -170,50 +170,50 @@ enum {
> > =C2=A0 * Processor Generic
> > =C2=A0 */
> > =C2=A0#define
> > CPER_SEC_PROC_GENERIC=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0\
> > -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0UUID_LE(0x9876CCAD, 0x47B4=
, 0x4bdb, 0xB6, 0x5E, 0x16,
> > 0xF1,=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0\
> > -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A00x93, 0xC4, 0xF3, 0xDB)
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0GUID_INIT(0x9876CCAD, 0x47=
B4, 0x4bdb, 0xB6, 0x5E, 0x16,
> > 0xF1,=C2=A0=C2=A0=C2=A0\
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A00x93, 0xC4, 0xF3, 0xDB)
> > =C2=A0/* Processor Specific: X86/X86_64 */
> > =C2=A0#define
> > CPER_SEC_PROC_IA=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0\
> > -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0UUID_LE(0xDC3EA0B0, 0xA144=
, 0x4797, 0xB9, 0x5B, 0x53,
> > 0xFA,=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0\
> > -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A00x24, 0x2B, 0x6E, 0x1D)
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0GUID_INIT(0xDC3EA0B0, 0xA1=
44, 0x4797, 0xB9, 0x5B, 0x53,
> > 0xFA,=C2=A0=C2=A0=C2=A0\
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A00x24, 0x2B, 0x6E, 0x1D)
> > =C2=A0/* Processor Specific: IA64 */
> > =C2=A0#define
> > CPER_SEC_PROC_IPF=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0\
> > -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0UUID_LE(0xE429FAF1, 0x3CB7=
, 0x11D4, 0x0B, 0xCA, 0x07,
> > 0x00,=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0\
> > -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A00x80, 0xC7, 0x3C, 0x88, 0x81)
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0GUID_INIT(0xE429FAF1, 0x3C=
B7, 0x11D4, 0x0B, 0xCA, 0x07,
> > 0x00,=C2=A0=C2=A0=C2=A0\
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A00x80, 0xC7, 0x3C, 0x88, 0x81)
> > =C2=A0/* Processor Specific: ARM */
> > =C2=A0#define
> > CPER_SEC_PROC_ARM=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0\
> > -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0UUID_LE(0xE19E3D16, 0xBC11=
, 0x11E4, 0x9C, 0xAA, 0xC2,
> > 0x05,=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0\
> > -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A00x1D, 0x5D, 0x46, 0xB0)
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0GUID_INIT(0xE19E3D16, 0xBC=
11, 0x11E4, 0x9C, 0xAA, 0xC2,
> > 0x05,=C2=A0=C2=A0=C2=A0\
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A00x1D, 0x5D, 0x46, 0xB0)
> > =C2=A0/* Platform Memory */
> > =C2=A0#define
> > CPER_SEC_PLATFORM_MEM=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0\
> > -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0UUID_LE(0xA5BC1114, 0x6F64=
, 0x4EDE, 0xB8, 0x63, 0x3E,
> > 0x83,=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0\
> > -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A00xED, 0x7C, 0x83, 0xB1)
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0GUID_INIT(0xA5BC1114, 0x6F=
64, 0x4EDE, 0xB8, 0x63, 0x3E,
> > 0x83,=C2=A0=C2=A0=C2=A0\
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A00xED, 0x7C, 0x83, 0xB1)
> > =C2=A0#define
> > CPER_SEC_PCIE=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0\
> > -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0UUID_LE(0xD995E954, 0xBBC1=
, 0x430F, 0xAD, 0x91, 0xB4,
> > 0x4D,=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0\
> > -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A00xCB, 0x3C, 0x6F, 0x35)
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0GUID_INIT(0xD995E954, 0xBB=
C1, 0x430F, 0xAD, 0x91, 0xB4,
> > 0x4D,=C2=A0=C2=A0=C2=A0\
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A00xCB, 0x3C, 0x6F, 0x35)
> > =C2=A0/* Firmware Error Record Reference */
> > =C2=A0#define
> > CPER_SEC_FW_ERR_REC_REF=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0
> > =C2=A0=C2=A0=C2=A0\
> > -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0UUID_LE(0x81212A96, 0x09ED=
, 0x4996, 0x94, 0x71, 0x8D,
> > 0x72,=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0\
> > -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A00x9C, 0x8E, 0x69, 0xED)
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0GUID_INIT(0x81212A96, 0x09=
ED, 0x4996, 0x94, 0x71, 0x8D,
> > 0x72,=C2=A0=C2=A0=C2=A0\
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A00x9C, 0x8E, 0x69, 0xED)
> > =C2=A0/* PCI/PCI-X Bus */
> > =C2=A0#define
> > CPER_SEC_PCI_X_BUS=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0\
> > -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0UUID_LE(0xC5753963, 0x3B84=
, 0x4095, 0xBF, 0x78, 0xED,
> > 0xDA,=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0\
> > -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A00xD3, 0xF9, 0xC9, 0xDD)
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0GUID_INIT(0xC5753963, 0x3B=
84, 0x4095, 0xBF, 0x78, 0xED,
> > 0xDA,=C2=A0=C2=A0=C2=A0\
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A00xD3, 0xF9, 0xC9, 0xDD)
> > =C2=A0/* PCI Component/Device */
> > =C2=A0#define
> > CPER_SEC_PCI_DEV=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0\
> > -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0UUID_LE(0xEB5E4685, 0xCA66=
, 0x4769, 0xB6, 0xA2, 0x26,
> > 0x06,=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0\
> > -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A00x8B, 0x00, 0x13, 0x26)
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0GUID_INIT(0xEB5E4685, 0xCA=
66, 0x4769, 0xB6, 0xA2, 0x26,
> > 0x06,=C2=A0=C2=A0=C2=A0\
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A00x8B, 0x00, 0x13, 0x26)
> > =C2=A0#define
> > CPER_SEC_DMAR_GENERIC=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0\
> > -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0UUID_LE(0x5B51FEF7, 0xC79D=
, 0x4434, 0x8F, 0x1B, 0xAA,
> > 0x62,=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0\
> > -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A00xDE, 0x3E, 0x2C, 0x64)
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0GUID_INIT(0x5B51FEF7, 0xC7=
9D, 0x4434, 0x8F, 0x1B, 0xAA,
> > 0x62,=C2=A0=C2=A0=C2=A0\
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A00xDE, 0x3E, 0x2C, 0x64)
> > =C2=A0/* Intel VT for Directed I/O specific DMAr */
> > =C2=A0#define
> > CPER_SEC_DMAR_VT=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0\
> > -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0UUID_LE(0x71761D37, 0x32B2=
, 0x45cd, 0xA7, 0xD0, 0xB0,
> > 0xFE,=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0\
> > -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A00xDD, 0x93, 0xE8, 0xCF)
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0GUID_INIT(0x71761D37, 0x32=
B2, 0x45cd, 0xA7, 0xD0, 0xB0,
> > 0xFE,=C2=A0=C2=A0=C2=A0\
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A00xDD, 0x93, 0xE8, 0xCF)
> > =C2=A0/* IOMMU specific DMAr */
> > =C2=A0#define
> > CPER_SEC_DMAR_IOMMU=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0\
> > -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0UUID_LE(0x036F84E1, 0x7F37=
, 0x428c, 0xA7, 0x9E, 0x57,
> > 0x5F,=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0\
> > -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A00xDF, 0xAA, 0x84, 0xEC)
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0GUID_INIT(0x036F84E1, 0x7F=
37, 0x428c, 0xA7, 0x9E, 0x57,
> > 0x5F,=C2=A0=C2=A0=C2=A0\
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A00xDF, 0xAA, 0x84, 0xEC)
> >=20
> > =C2=A0#define CPER_PROC_VALID_TYPE=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A00x0001
> > =C2=A0#define CPER_PROC_VALID_ISA=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A00x0002
> > @@ -290,10 +290,10 @@ struct cper_record_header {
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0__u32=C2=A0=C2=A0=C2=A0=
validation_bits;
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0__u32=C2=A0=C2=A0=C2=A0=
record_length;
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0__u64=C2=A0=C2=A0=C2=A0=
timestamp;
> > -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0uuid_le platform_id;
> > -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0uuid_le partition_id;
> > -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0uuid_le creator_id;
> > -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0uuid_le notification_type;
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0guid_t=C2=A0=C2=A0platform=
_id;
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0guid_t=C2=A0=C2=A0partitio=
n_id;
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0guid_t=C2=A0=C2=A0creator_=
id;
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0guid_t=C2=A0=C2=A0notifica=
tion_type;
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0__u64=C2=A0=C2=A0=C2=A0=
record_id;
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0__u32=C2=A0=C2=A0=C2=A0=
flags;
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0__u64=C2=A0=C2=A0=C2=A0=
persistence_information;
> > @@ -309,8 +309,8 @@ struct cper_section_descriptor {
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0__u8=C2=A0=C2=A0=C2=A0=
=C2=A0validation_bits;
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0__u8=C2=A0=C2=A0=C2=A0=
=C2=A0reserved;=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0/* must be zero */
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0__u32=C2=A0=C2=A0=C2=A0=
flags;
> > -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0uuid_le section_type;
> > -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0uuid_le fru_id;
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0guid_t=C2=A0=C2=A0section_=
type;
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0guid_t=C2=A0=C2=A0fru_id;
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0__u32=C2=A0=C2=A0=C2=A0=
section_severity;
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0__u8=C2=A0=C2=A0=C2=A0=
=C2=A0fru_text[20];
> > =C2=A0};
> > @@ -343,7 +343,7 @@ struct cper_sec_proc_ia {
> >=20
> > =C2=A0/* IA32/X64 Processor Error Information Structure */
> > =C2=A0struct cper_ia_err_info {
> > -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0uuid_le err_type;
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0guid_t=C2=A0=C2=A0err_type=
;
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0__u64=C2=A0=C2=A0=C2=A0=
validation_bits;
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0__u64=C2=A0=C2=A0=C2=A0=
check_info;
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0__u64=C2=A0=C2=A0=C2=A0=
target_id;
> > diff --git a/include/linux/efi.h b/include/linux/efi.h
> > index 8269bcb8ccf7..7a322aed979f 100644
> > --- a/include/linux/efi.h
> > +++ b/include/linux/efi.h
> > @@ -47,10 +47,10 @@ typedef u16 efi_char16_t;=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0/* UNICODE
> > character */
> > =C2=A0typedef u64 efi_physical_addr_t;
> > =C2=A0typedef void *efi_handle_t;
> >=20
> > -typedef uuid_le efi_guid_t;
> > +typedef guid_t efi_guid_t;
> >=20
> > =C2=A0#define EFI_GUID(a,b,c,d0,d1,d2,d3,d4,d5,d6,d7) \
> > -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0UUID_LE(a, b, c, d0, d1, d=
2, d3, d4, d5, d6, d7)
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0GUID_INIT(a, b, c, d0, d1,=
 d2, d3, d4, d5, d6, d7)
> >=20
> > =C2=A0/*
> > =C2=A0 * Generic EFI table header
> > --
> > 2.11.0
> >=20

--=20
Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Intel Finland Oy
--
To unsubscribe from this list: send the line "unsubscribe linux-watchdog"=
 in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
